Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbULRUSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbULRUSb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 15:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbULRUSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 15:18:31 -0500
Received: from CPE0050fc332afc-CM00407b861c34.cpe.net.cable.rogers.com ([69.197.25.155]:54144
	"EHLO nuku.localdomain") by vger.kernel.org with ESMTP
	id S261228AbULRURr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 15:17:47 -0500
Date: Sat, 18 Dec 2004 15:20:03 -0500
From: Rashkae <rashkae@tigershaunt.com>
To: Jens Axboe <axboe@suse.de>
Cc: Kronos <kronos@kronoz.cjb.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Cannot mount multi-session DVD with ide-cd, must use ide-scsi
Message-ID: <20041218202003.GB4541@tigershaunt.com>
References: <20041217120854.GC3140@suse.de> <20041217183303.GA9561@dreamland.darkstar.lan> <20041217192738.GJ3140@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217192738.GJ3140@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 08:27:38PM +0100, Jens Axboe wrote:

> > Ok, changed that part. I also changed the part inside the #if
> > !STANDARD_ATAPI to re-read using MSF, just to be sure to not break
> > anything. Maybe those two weird units (Vertos 300 and NEC 260) return
> > the LBA value in a sane way and the whole #if block can be removed? 
> 
> Much better, Andrew will you pick this up?

Working well for me so far, at least, as far as the problem I
whined about goes :)
