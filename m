Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265898AbSKKTQg>; Mon, 11 Nov 2002 14:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265900AbSKKTQg>; Mon, 11 Nov 2002 14:16:36 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:60399 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S265898AbSKKTQf>;
	Mon, 11 Nov 2002 14:16:35 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15824.915.758329.73126@napali.hpl.hp.com>
Date: Mon, 11 Nov 2002 11:22:59 -0800
To: Mario Smarduch <cms063@email.mot.com>
Cc: linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org
In-Reply-To: <3DCFDAE9.6D359448@email.mot.com>
References: <20021109041543.EBE8A2C29F@lists.samba.org>
	<3DCFDAE9.6D359448@email.mot.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 11 Nov 2002 10:29:29 -0600, Mario Smarduch <cms063@email.mot.com> said:

  Mario> I know that on some commercial Unix systems there are ways to
  Mario> cap the CPU utilization by user/group ids are there such
  Mario> features/patches available on Linux?

There are probably other patches floating around, but Process Resource
Management (PRM) for Linux is/was one approach to do just that:

	http://resourcemanagement.unixsolutions.hp.com/WaRM/prm_linux/

The kernel patches available from this URL are pretty old (up to
2.4.6, as far as I could see), and I'm not sure what the future plans
for PRM on Linux are.  Perhaps someone else can provide more details.

	--david
