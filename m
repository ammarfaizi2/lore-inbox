Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293046AbSCFCFI>; Tue, 5 Mar 2002 21:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293047AbSCFCE6>; Tue, 5 Mar 2002 21:04:58 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:978 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S293046AbSCFCEq>;
	Tue, 5 Mar 2002 21:04:46 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15493.31034.461025.106304@napali.hpl.hp.com>
Date: Tue, 5 Mar 2002 18:04:42 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@napali.hpl.hp.com, sp@scali.com, adam@yggdrasil.com,
        linux-kernel@vger.kernel.org
Subject: Re: Does kmalloc always return address below 4GB?
In-Reply-To: <20020305.175238.102577593.davem@redhat.com>
In-Reply-To: <15492.62946.952197.632931@napali.hpl.hp.com>
	<20020305.170909.78708394.davem@redhat.com>
	<15493.29045.798709.577904@napali.hpl.hp.com>
	<20020305.175238.102577593.davem@redhat.com>
X-Mailer: VM 7.01 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 05 Mar 2002 17:52:38 -0800 (PST), "David S. Miller" <davem@redhat.com> said:

  DaveM> So when someone tells me "on ia64, with 8gb ram, my eepro100
  DaveM> card gets really crap performance under any load" I will
  DaveM> explain the above to them and let them know that the
  DaveM> performance sucks because the ia64 folks refuse to integrate
  DaveM> this bug fix :-)

I think you're ignoring disk I/O.

I'm not terribly interested in revisiting this topic.  If you care,
take it up with the folks that build the chips without hardware I/O
TLB.  They are the ones with the vested interest. ;-)

	--david
