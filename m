Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290746AbSBLDd0>; Mon, 11 Feb 2002 22:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290749AbSBLDdQ>; Mon, 11 Feb 2002 22:33:16 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:5569 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S290746AbSBLDdB>;
	Mon, 11 Feb 2002 22:33:01 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15464.36074.246502.582895@napali.hpl.hp.com>
Date: Mon, 11 Feb 2002 19:32:58 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, anton@samba.org, linux-kernel@vger.kernel.org,
        zippel@linux-m68k.org
Subject: Re: thread_info implementation
In-Reply-To: <20020211.192334.123921982.davem@redhat.com>
In-Reply-To: <15464.34183.282646.869983@napali.hpl.hp.com>
	<20020211.190449.55725714.davem@redhat.com>
	<15464.35214.669412.477377@napali.hpl.hp.com>
	<20020211.192334.123921982.davem@redhat.com>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 11 Feb 2002 19:23:34 -0800 (PST), "David S. Miller" <davem@redhat.com> said:

  DaveM> The compiler will schedule the latency out of existence.

The kernel has many paths that have sequential dependencies.  If there
is no other work to do, the compiler won't help you.

	--david
