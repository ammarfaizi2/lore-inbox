Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292958AbSCFBb6>; Tue, 5 Mar 2002 20:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292975AbSCFBbs>; Tue, 5 Mar 2002 20:31:48 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:58049 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S292958AbSCFBbh>;
	Tue, 5 Mar 2002 20:31:37 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15493.29045.798709.577904@napali.hpl.hp.com>
Date: Tue, 5 Mar 2002 17:31:33 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@napali.hpl.hp.com, sp@scali.com, adam@yggdrasil.com,
        linux-kernel@vger.kernel.org
Subject: Re: Does kmalloc always return address below 4GB?
In-Reply-To: <20020305.170909.78708394.davem@redhat.com>
In-Reply-To: <3C84E785.1D102FF9@scali.com>
	<20020305.074722.25911127.davem@redhat.com>
	<15492.62946.952197.632931@napali.hpl.hp.com>
	<20020305.170909.78708394.davem@redhat.com>
X-Mailer: VM 7.01 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 05 Mar 2002 17:09:09 -0800 (PST), "David S. Miller" <davem@redhat.com> said:

  DaveM> Oh I didn't know you didn't use those changes.

No we don't.  We discussed it but the feeling was that the swiotlb is
overall the better choice (for 2.4.xx).  I don't really care about
this issue all that much myself, as it affects only platforms that
don't have a hardware I/O TLB and use PCI cards that can't address the
entire physical address space.

  DaveM> Your version is still broken then.

Ah, classic DaveM.  You're obviously entitled to your opinion.

	--david
