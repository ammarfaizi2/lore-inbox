Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbTBLJks>; Wed, 12 Feb 2003 04:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266983AbTBLJks>; Wed, 12 Feb 2003 04:40:48 -0500
Received: from mail.dsa-ac.de ([62.112.80.99]:38919 "HELO k2.dsa-ac.de")
	by vger.kernel.org with SMTP id <S266977AbTBLJkr>;
	Wed, 12 Feb 2003 04:40:47 -0500
Date: Wed, 12 Feb 2003 10:50:32 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.60 "Badness in kobject_register at lib/kobject.c:152"
In-Reply-To: <1044969981.12906.21.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0302121049480.1173-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Known problem. Its probably fixed in the 2.4 changes I made to the
> probe and flash bits yesterday. Its two bugs together. The vanishing
> disk is definitely fixed, the oops from drive->id = NULL should be
> sorted too (and the general noprobe, cdrom cases)

Ok, found it - 21-pre4-ac4, right? Sorry, should've checked before
writing... Trying...

Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

