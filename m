Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290770AbSBLFui>; Tue, 12 Feb 2002 00:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290782AbSBLFu3>; Tue, 12 Feb 2002 00:50:29 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:47828 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S290770AbSBLFuU>;
	Tue, 12 Feb 2002 00:50:20 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15464.44308.466416.233260@napali.hpl.hp.com>
Date: Mon, 11 Feb 2002 21:50:12 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: rth@twiddle.net, davidm@hpl.hp.com, anton@samba.org,
        linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: thread_info implementation
In-Reply-To: <20020211.213248.48398226.davem@redhat.com>
In-Reply-To: <20020211.192334.123921982.davem@redhat.com>
	<15464.36074.246502.582895@napali.hpl.hp.com>
	<20020211212644.A20387@twiddle.net>
	<20020211.213248.48398226.davem@redhat.com>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 11 Feb 2002 21:32:48 -0800 (PST), "David S. Miller" <davem@redhat.com> said:

  DaveM> BTW, your "4 issue" comments assume the cpu can do 4 non-FPU
  DaveM> instructions per cycle, most I am aware of cannot and I think ia64
  DaveM> even falls into the "cannot" category.  Doesn't it?

Itanium can certainly issue 5 non-fp instructions per cycle (not very
common, but possible).  4-issue is easy.

	--david
