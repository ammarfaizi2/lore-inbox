Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262844AbTCZBMA>; Tue, 25 Mar 2003 20:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263029AbTCZBMA>; Tue, 25 Mar 2003 20:12:00 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:3844 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262844AbTCZBL7>;
	Tue, 25 Mar 2003 20:11:59 -0500
Date: Tue, 25 Mar 2003 17:22:27 -0800
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c driver changes for 2.5.66
Message-ID: <20030326012227.GB19868@kroah.com>
References: <10485563141404@kroah.com> <3E801EA1.40709@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E801EA1.40709@portrix.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 10:17:21AM +0100, Jan Dittmer wrote:
> Greg KH wrote:
> >ChangeSet 1.889.355.14, 2003/03/22 23:20:40-08:00, greg@kroah.com
> >
> >i2c: fix up drivers/media/video/* due to previous i2c changes.
> >
> 
> Additionally I need the following patch to tvmixer.c to compile properly 
> with CONFIG_SOUND_TVMIXER=m. Just a /client->name/client->dev.name/g.

Thanks, I've applied this to my kernel trees and will send it on to
Linus with the next batch of i2c patches.

thanks,

greg k-h
