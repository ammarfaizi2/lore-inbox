Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWBJXnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWBJXnF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 18:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWBJXnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 18:43:05 -0500
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:25641 "EHLO
	BAYC1-PASMTP11.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751391AbWBJXnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 18:43:04 -0500
Message-ID: <BAYC1-PASMTP11631D316096854AF9EA67AE020@CEZ.ICE>
X-Originating-IP: [65.94.251.146]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Fri, 10 Feb 2006 18:42:41 -0500
From: sean <seanlkml@sympatico.ca>
To: Bill Davidsen <davidsen@tmr.com>
Cc: nix@esperi.org.uk, axboe@suse.de, schilling@fokus.fraunhofer.de,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-Id: <20060210184241.35332e78.seanlkml@sympatico.ca>
In-Reply-To: <43ED005F.5060804@tmr.com>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
	<Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
	<20060125144543.GY4212@suse.de>
	<Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
	<20060125153057.GG4212@suse.de>
	<43D7AF56.nailDFJ882IWI@burner>
	<20060125181847.b8ca4ceb.grundig@teleline.es>
	<20060125173127.GR4212@suse.de>
	<43D7C1DF.1070606@gmx.de>
	<878xt3rfjc.fsf@amaterasu.srvr.nix>
	<43ED005F.5060804@tmr.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.11; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2006 23:45:18.0718 (UTC) FILETIME=[0C9009E0:01C62E9C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2006 16:06:39 -0500
Bill Davidsen <davidsen@tmr.com> wrote:


> I notice that the first thing people suggest is to make things like 
> udev, hal and sysfs required instead of optional to do something as 
> simple as burn a CD. 
> [snip]

All that is required is a proper device node in /dev; is this really
so much of a burden?   This device node can be created statically
at install time or via udev or any other method.   In fact if you're 
using udev and a device node isn't automatically created for all 
of your cd burners, you can file a bug report and get it fixed.   So in 
the end all you ever have to teach a user is to pick the device they
want from /dev.

Sean
