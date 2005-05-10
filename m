Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVEJCFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVEJCFk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 22:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVEJCFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 22:05:40 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:60039 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261482AbVEJCFf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 22:05:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WcsQoMQFrvaxK8d01+LUMyj3sv6jd5u0wvZyLYcP4COjoKuUFC3oL3gxdg4T1H28hWN6fuc21BJJ1zZoJL4eC2bjUgdVCfUkYwgeRKm22UGj/N/GW+VirYZlYotexQKtiPHi0Qazy9JgvE4lhlgjm53jF0svgBVfl8TH0CYqivs=
Message-ID: <5eb4b065050509190549b1100d@mail.gmail.com>
Date: Tue, 10 May 2005 10:05:34 +0800
From: KC <kcc1967@gmail.com>
Reply-To: KC <kcc1967@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: proc_mknod() replacement
Cc: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200505092107.j49L7J7C028882@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5eb4b06505050904172655477c@mail.gmail.com>
	 <20050509154147.GC5799@harddisk-recovery.com>
	 <5eb4b065050509100638bd7970@mail.gmail.com>
	 <200505092107.j49L7J7C028882@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/05, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Tue, 10 May 2005 01:06:08 +0800, KC said:
> 
> > Why I want to use proc_mknod() in driver ?  I write a small package, ovi-dev,
> > which can be downloaded from
> > http://www.sourceforge.net/projects/ovi
> > The ovi-dev will scan the PCI bus and if it found, eg, 3 PCI devices, it
> > will create 3 device entries (nodes) automatically at module load time.
> > So number of device entries (nodes) will match number of devices
> > of the system ... well, UNIX/Linux doesn't work that way ... there are a lot
> > of device entries ... but no corresponding hardware existed.
> 
> Congrats.  You've re-invented udev.

No, it's not ... dynamic entry is not my purpose, but a good
feature which I want to have in my package and I did it using
proc_mknod() for 2.4.x ... 
Anyway, I'll check udev to see if it's enough for me.

Thanks
KC

> 
> 
>
