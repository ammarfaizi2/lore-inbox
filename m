Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290803AbSBLHEK>; Tue, 12 Feb 2002 02:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290805AbSBLHDu>; Tue, 12 Feb 2002 02:03:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53769 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S290803AbSBLHDj>;
	Tue, 12 Feb 2002 02:03:39 -0500
Date: Tue, 12 Feb 2002 08:03:22 +0100
From: Jens Axboe <axboe@suse.de>
To: reddog83 <reddog83@chartermi.net>
Cc: Paul Fulghum <paulkf@microgate.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.3-dj5 synclink.c fix so that it compiles
Message-ID: <20020212080322.U729@suse.de>
In-Reply-To: <auto-000058815980@front2.chartermi.net> <001701c1b312$24448ca0$0c00a8c0@diemos> <auto-000058467594@front1.chartermi.net> <20020212075636.T729@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020212075636.T729@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12 2002, Jens Axboe wrote:
> On Mon, Feb 11 2002, reddog83 wrote:
> > Paul-
> > That is understandable. I had  the same guess as you when I made this patch. 
> > Why is ths synclink.c driver using DMA Mapping. After I took that line out I 
> > was fine becuase my system is fine. 
> 
> The "real" fix for synclink is just something like this, afaics.

Agrh, scratch that. It's not ISA only of course, my bad.

-- 
Jens Axboe

