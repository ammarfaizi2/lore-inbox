Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBJUkA>; Sat, 10 Feb 2001 15:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129027AbRBJUju>; Sat, 10 Feb 2001 15:39:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64010 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129026AbRBJUje>;
	Sat, 10 Feb 2001 15:39:34 -0500
Date: Sat, 10 Feb 2001 21:39:22 +0100
From: Jens Axboe <axboe@suse.de>
To: LA Walsh <law@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: question on comment in fs.h
Message-ID: <20010210213922.C403@suse.de>
In-Reply-To: <3A85A5EC.EFE3F703@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A85A5EC.EFE3F703@sgi.com>; from law@sgi.com on Sat, Feb 10, 2001 at 12:34:52PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10 2001, LA Walsh wrote:
> Excuse my ignorance, but in file include/linux/fs.h, 2.4.x source
> in the struct buffer_head, there is a member:
> 	unsigned short b_size;          /* block size */    
> later there is a member:
> 	char * b_data;                  /* pointer to data block (512 byte) */ 
> 
> Is the "(512 byte)" part of the comment in error or do I misunderstand
> the nature of 'b_size'

The comment is old and wrong

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
