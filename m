Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316721AbSEQXUB>; Fri, 17 May 2002 19:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316724AbSEQXUA>; Fri, 17 May 2002 19:20:00 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:50956 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316721AbSEQXT7>;
	Fri, 17 May 2002 19:19:59 -0400
Date: Fri, 17 May 2002 16:19:46 -0700
From: Greg KH <greg@kroah.com>
To: Pozsar Balazs <pozsy@sch.bme.hu>
Cc: =?iso-8859-1?Q?J=F6rg?= Prante <joergprante@gmx.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] 2.4.19-pre8-jp12
Message-ID: <20020517231946.GD7970@kroah.com>
In-Reply-To: <200205150007.AWD57178@netmail.netcologne.de> <Pine.GSO.4.30.0205160941040.956-100000@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 19 Apr 2002 21:55:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2002 at 09:47:14AM +0200, Pozsar Balazs wrote:
> 
> I tried it. First I had a lot of compile problems (everything as module),
> I had to disable at least 5 drivers (sorry I don't know exactly which were
> them).
> After compiling, depmod -a says:
> 
> unresolved symbols in
> /drivers/hotplug/pcihpacpi.o

What is the unresolved symbol here?  acpi_walk_something_or_other?

Do you really want to use this driver (i.e. do you have a machine that
has a ACPI PCI Hotplug controller?)

thanks,

greg k-h
