Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266964AbSLDJSI>; Wed, 4 Dec 2002 04:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266969AbSLDJSH>; Wed, 4 Dec 2002 04:18:07 -0500
Received: from mail.zmailer.org ([62.240.94.4]:20919 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S266964AbSLDJSF>;
	Wed, 4 Dec 2002 04:18:05 -0500
Date: Wed, 4 Dec 2002 11:25:36 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Paresh Sawant <p.Sawant@zensar.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-c-programming@vger.kernel.org
Subject: Re: struct to be passed to ioctl call for commanf HDIO_DRIVE_CMD
Message-ID: <20021204092536.GB1099@mea-ext.zmailer.org>
References: <54670264D99F034EA23CBB7D7A45AE7E5ECD@zenmail1.ind.zensar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54670264D99F034EA23CBB7D7A45AE7E5ECD@zenmail1.ind.zensar.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 02:38:18PM +0530, Paresh Sawant wrote:
> Hi!
>         I want to send ATA command to IDE hard disk driver using ioctl 
>	  with comand "HDIO_DRIVE_CMD", to do raw write to hard disk. 
>	  Which Struct i should pass to ioctl call as a third argument ?

  Read the source of  ide_cmd_ioctl()   at  drivers/ide/ide-taskfile.c
  Presently that is the only documentation on it.

> thanks 
> paresh
