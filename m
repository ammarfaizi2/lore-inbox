Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267214AbSKUXzz>; Thu, 21 Nov 2002 18:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267213AbSKUXzz>; Thu, 21 Nov 2002 18:55:55 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:27655
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267214AbSKUXyo>; Thu, 21 Nov 2002 18:54:44 -0500
Date: Thu, 21 Nov 2002 16:00:34 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Mark Mielke <mark@mark.mielke.cc>
cc: Arjan van de Ven <arjanv@redhat.com>,
       David McIlwraith <quack@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: spinlocks, the GPL, and binary-only modules
In-Reply-To: <20021121170224.GB5315@mark.mielke.cc>
Message-ID: <Pine.LNX.4.10.10211211522390.3892-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2002, Mark Mielke wrote:

> Some (not all) of the inlined functions are 'inline' to accelerate the
> kernel.

Point is noted and the performance issue stands on its own as a strike
against removing the inline, this is a given.  Now what is the performance
difference if the inline is moved to a .c and makd and extern inline in
the .h ?

The object of the question is determine if there is a peformance break
point to consider the moving of a inlined C code to a proper .c file.

Obviously adding a new kernel fork to move around the inline game will be
painful but if it narrows the gap between black and white to remove
the chance of accidentail GPL code inclusion.  It may be worth it to
consider.

Comments and Flames welcome.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


