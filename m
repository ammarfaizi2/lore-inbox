Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290753AbSBLEQp>; Mon, 11 Feb 2002 23:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290755AbSBLEQf>; Mon, 11 Feb 2002 23:16:35 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:36296 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S290753AbSBLEQa>;
	Mon, 11 Feb 2002 23:16:30 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15464.38684.48286.317465@napali.hpl.hp.com>
Date: Mon, 11 Feb 2002 20:16:28 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, anton@samba.org, linux-kernel@vger.kernel.org,
        zippel@linux-m68k.org
Subject: Re: thread_info implementation
In-Reply-To: <20020211.194222.34761071.davem@redhat.com>
In-Reply-To: <15464.35214.669412.477377@napali.hpl.hp.com>
	<20020211.192334.123921982.davem@redhat.com>
	<15464.36074.246502.582895@napali.hpl.hp.com>
	<20020211.194222.34761071.davem@redhat.com>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 11 Feb 2002 19:42:22 -0800 (PST), "David S. Miller" <davem@redhat.com> said:

  DaveM> I totally beg to
  DaveM> differ, and I think people like Linus will too.

I don't think so.  In the not-so-distant past, Linus has rejected a
patch for precisely this reason.  And in that particular case, only a
handful of places had a local variable replaced with current->cpu.

	--david
