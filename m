Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316991AbSGCJfd>; Wed, 3 Jul 2002 05:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316993AbSGCJfc>; Wed, 3 Jul 2002 05:35:32 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:373 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S316991AbSGCJfb>;
	Wed, 3 Jul 2002 05:35:31 -0400
Date: Wed, 3 Jul 2002 11:37:58 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hd_geometry question.
Message-ID: <20020703093758.GA22119@win.tue.nl>
References: <OFC6BCF5FE.976DF5FA-ONC1256BEB.002C62D4@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFC6BCF5FE.976DF5FA-ONC1256BEB.002C62D4@de.ibm.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2002 at 10:13:19AM +0200, Martin Schwidefsky wrote:

> The problem now is that if geo.start is REQUIRED to be measured in
> 512 byte blocks we have to incompatibly change the HDIO_GETGEO ioctl.
> Not nice.

Yes, unfortunate. But the change will break very little, if anything.
Leave things as they are in 2.4, and change in 2.5.
Many years from now, when people upgrade from 2.4 to 2.6,
this will be one of the minor differences.

And maybe HDIO_GETGEO will be removed entirely.

Andries

