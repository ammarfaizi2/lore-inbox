Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbTKVR3M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 12:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTKVR3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 12:29:12 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:40199 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262558AbTKVR3E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 12:29:04 -0500
Date: Sat, 22 Nov 2003 18:29:02 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: marcelo@cyclades.com, linux-kernel@vger.kernel.org,
       sensors@Stimpy.netroedge.com, greg@kroah.com
Subject: Re: [PATCH 2.4] Trivial changes to I2C stuff
Message-Id: <20031122182902.26f859fd.khali@linux-fr.org>
In-Reply-To: <20031122154720.GA18110@alpha.home.local>
References: <20031122161510.7d5b4d20.khali@linux-fr.org>
	<20031122154720.GA18110@alpha.home.local>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -199,7 +199,7 @@
> >  #define I2C_HW_SMBUS_AMD756	0x05
> >  #define I2C_HW_SMBUS_SIS5595	0x06
> >  #define I2C_HW_SMBUS_ALI1535	0x07
> > -#define I2C_HW_SMBUS_W9968CF	0x08
> > +#define I2C_HW_SMBUS_W9968CF	0x0d
> 
> Is this one intentionnal or just a typo ?

Intentional. 0x08 is I2C_HW_SMBUS_SIS630 in both i2c-CVS and Linux 2.6.0-test9, so I chose the next available ID, which happens to be 0x0d. Anyway, these IDs have no real use AFAIK, so there is nothing to be afraid of here.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
