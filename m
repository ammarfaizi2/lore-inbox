Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280322AbRKEH5n>; Mon, 5 Nov 2001 02:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280323AbRKEH5Y>; Mon, 5 Nov 2001 02:57:24 -0500
Received: from zero.tech9.net ([209.61.188.187]:56590 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S280322AbRKEH5N>;
	Mon, 5 Nov 2001 02:57:13 -0500
Subject: Re: 2.4.13-ac5-preempt, overflow in cached memory stat?
From: Robert Love <rml@tech9.net>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111031149260.30382-100000@netfinity.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.33.0111031149260.30382-100000@netfinity.realnet.co.sz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.28.13.59 (Preview Release)
Date: 05 Nov 2001 02:56:36 -0500
Message-Id: <1004946998.806.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-11-03 at 04:51, Zwane Mwaikambo wrote:
> I experienced a power loss and upon booting of the system, fsck was run on
> my / partition (ext3). When it was done i noticed the following;

ac7 contains a fix for cache memory accounting; I think it would fix
your problem.  can you give it a try?  the preempt patch for ac6 should
apply fine...

	Robert Love

