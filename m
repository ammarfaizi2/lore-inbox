Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262165AbSIZDd2>; Wed, 25 Sep 2002 23:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262167AbSIZDd2>; Wed, 25 Sep 2002 23:33:28 -0400
Received: from mnh-1-19.mv.com ([207.22.10.51]:9221 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S262165AbSIZDd1>;
	Wed, 25 Sep 2002 23:33:27 -0400
Message-Id: <200209260442.XAA05023@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Ben Collins <bcollins@debian.org>, Shanti Katta <katta@csee.wvu.edu>
Cc: sparc-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Reg Sparc memory addresses 
In-Reply-To: Your message of "Wed, 25 Sep 2002 21:56:45 -0400."
             <20020926015645.GE28289@phunnypharm.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 25 Sep 2002 23:42:28 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bcollins@debian.org said:
> I'm not familiar with how UML runs in user space, but I suspect it
> needs to think it is sparc and not sparc64 for it to run in 32bit
> sparc userspace (which is what ultrasparc runs at for most cases).

It just wants to be a normal executable, except that it loads in a 
nonstandard location.  And it would be OK for it to load in the standard
location for the early debugging.

				Jeff

