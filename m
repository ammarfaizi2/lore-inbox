Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbTBTJgq>; Thu, 20 Feb 2003 04:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbTBTJgp>; Thu, 20 Feb 2003 04:36:45 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:50952 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265077AbTBTJgp>; Thu, 20 Feb 2003 04:36:45 -0500
Date: Thu, 20 Feb 2003 10:46:29 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Werner Almesberger <wa@almesberger.net>, <kuznet@ms2.inr.ac.ru>,
       <kronos@kronoz.cjb.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Is an alternative module interface needed/possible? 
In-Reply-To: <20030220003540.284ED2C489@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0302201040550.1336-100000@serv>
References: <20030220003540.284ED2C489@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 20 Feb 2003, Rusty Russell wrote:

> Yes, the addition of "umount -l" is congruent to "rmmod --wait".  The
> assumption is "I don't want any new users, and I'll handle any current
> ones".  You can get yourself in trouble with both of them.

With the small difference that "umount -l" won't deadlock.

bye, Roman

