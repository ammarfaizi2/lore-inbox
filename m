Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbTCEWBj>; Wed, 5 Mar 2003 17:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265570AbTCEWBj>; Wed, 5 Mar 2003 17:01:39 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:47878 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265567AbTCEWBj>;
	Wed, 5 Mar 2003 17:01:39 -0500
Date: Wed, 5 Mar 2003 14:02:34 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Wolfgang Muees <wolfgang@iksw-muees.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.4.21-pre5: fix Auerswald compile
Message-ID: <20030305220233.GC30933@kroah.com>
References: <Pine.LNX.4.53L.0302270314050.1433@freak.distro.conectiva> <20030227232612.GV7685@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030227232612.GV7685@fs.tum.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 12:26:12AM +0100, Adrian Bunk wrote:
> 
> auerdev_table and auerdev_table_mutex are static in auermain.c but used
> from auerchar.c. The following patch makes them non-static:

Applied to my trees, thanks.

greg k-h
