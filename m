Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbTA1Mqv>; Tue, 28 Jan 2003 07:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265262AbTA1Mqu>; Tue, 28 Jan 2003 07:46:50 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26240
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S265255AbTA1Mqu>; Tue, 28 Jan 2003 07:46:50 -0500
Subject: Re: Bootscreen
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030128114840.GV4868@wiggy.net>
References: <Pine.LNX.4.44.0301281113480.20283-100000@schubert.rdns.com>
	 <200301281144.h0SBi0ld000233@darkstar.example.net>
	 <20030128114840.GV4868@wiggy.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043758528.8100.35.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 28 Jan 2003 12:55:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-28 at 11:48, Wichert Akkerman wrote:
> Previously John Bradford wrote:
> > There are applications where it is not appropriate to have it, though,
> > what if you were using Linux in an embedded device such as a set top
> > box?
> 
> Kiosks and things like ATMs are another place where you do not want
> a bootscreen. You do not want to possibly confuse customers with
> stuff that they can't understand but show a nice friendly message saying
> 'the system is currently unavailable'.

The real question is whether you want to do this in the kernel or simply at
the moment the kernel flips to user space. An init can easily open vt2,
draw a pretty boot screen with something like nanogui or bogl and then 
continue to spew the text to vt1 so anyone can see the text messages if
need be.


