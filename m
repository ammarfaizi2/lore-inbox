Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267001AbTAPDko>; Wed, 15 Jan 2003 22:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267011AbTAPDko>; Wed, 15 Jan 2003 22:40:44 -0500
Received: from rth.ninka.net ([216.101.162.244]:32483 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S267001AbTAPDkk>;
	Wed, 15 Jan 2003 22:40:40 -0500
Subject: Re: [RFC] Migrating net/sched to new module interface
From: "David S. Miller" <davem@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Werner Almesberger <wa@almesberger.net>,
       "Alexey N. Kuznetsov" <kuznet@ms2.inr.ac.ru>,
       Roman Zippel <zippel@linux-m68k.org>, kronos@kronoz.cjb.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030116033343.C87CF2C33D@lists.samba.org>
References: <20030116033343.C87CF2C33D@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Jan 2003 20:25:30 -0800
Message-Id: <1042691130.13364.1.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-15 at 19:31, Rusty Russell wrote:
> The ONLY time that FUNCTIONS vanish is when MODULES get UNLOADED (or
> fail to LOAD).

I totally agree with Rusty.  If you don't understand this fundamental
difference between module unloading vs. arbitrary kernel objects
going away, then you really need to apply some gray matter to it
before you continue in this conversation :)

