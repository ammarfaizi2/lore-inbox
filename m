Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264494AbTEJUMs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 16:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbTEJUMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 16:12:48 -0400
Received: from mail.gmx.net ([213.165.65.60]:42434 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264494AbTEJUMq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 16:12:46 -0400
Date: Sat, 10 May 2003 22:23:06 +0200
From: Tuncer M "zayamut" Ayaz <tuncer.ayaz@gmx.de>
To: Tuncer M "zayamut" Ayaz <tuncer.ayaz@gmx.de>
Cc: xavier.bestel@free.fr, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
In-Reply-To: <S264488AbTEJT4X/20030510195623Z+7092@vger.kernel.org>
References: <1405.1052575075@www9.gmx.net>
	<1052575167.16165.0.camel@dhcp22.swansea.linux.org.uk>
	<S264332AbTEJO5e/20030510145734Z+7011@vger.kernel.org>
	<S264373AbTEJPSN/20030510151813Z+1648@vger.kernel.org>
	<20030510162527.GD29271@mail.jlokier.co.uk>
	<S264444AbTEJQk4/20030510164056Z+1652@vger.kernel.org>
	<S264449AbTEJRZH/20030510172507Z+7050@vger.kernel.org>
	<1052588866.1013.3.camel@bip.localdomain.fake>
	<S264488AbTEJT4X/20030510195623Z+7092@vger.kernel.org>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <S264494AbTEJUMq/20030510201246Z+7104@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 May 2003 22:06:25 +0200
Tuncer M "zayamut" Ayaz <tuncer.ayaz@gmx.de> wrote:

> On 10 May 2003 19:47:47 +0200
> Xavier Bestel <xavier.bestel@free.fr> wrote:
> 
> > Le sam 10/05/2003 à 19:35, Tuncer M zayamut Ayaz a écrit :
> > 
> > > rebooted with a reconfigured kernel to assure it's not cpufreq.
> > > same behaviour without cpufreq.
> > 
> > You should perhaps try to enable/disable APM idle calls ..
> > 
> > 	Xav
> 
> disabling apm idle calls seem to fix it but on this notebook
> those calls are necessary so that it doesn't get too hot.
> or can ACPI be used to accomplish those calls?
> 
> I'm already running it always on SpeeStep power-saving mode
> so that it doesn't get REALLY hot. try typing on an Inspiron
> 8100 in the summer while compiling for a while. it's not
> healthy for your hands :D

besides fixing the noise issue by disabling a wanted feature,
somehow pcmcia is borked, it just doesn't work and print
lots of error messages and one of pcmcia processes (dunno which)
segfaults.
may be my fault, who knows. well, we'll see...
