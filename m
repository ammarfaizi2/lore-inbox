Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266203AbTALN23>; Sun, 12 Jan 2003 08:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266307AbTALN22>; Sun, 12 Jan 2003 08:28:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25062 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266203AbTALN22>;
	Sun, 12 Jan 2003 08:28:28 -0500
Date: Sun, 12 Jan 2003 14:37:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Paul Rolland <rol@witbe.net>, linux-kernel@vger.kernel.org
Cc: "'Sam Ravnborg'" <sam@ravnborg.org>, rol@as2917.net
Subject: Re: [BUG 2.5.56] IDE/CDROM Oops at boot time without /proc
Message-ID: <20030112133700.GF14017@suse.de>
References: <009401c2ba3f$3780a940$2101a8c0@witbe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009401c2ba3f$3780a940$2101a8c0@witbe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12 2003, Paul Rolland wrote:
> One easy trick would be to have :
> #ifdef CONFIG_PROC_FS
>         cdrom_root_table->child->de->owner = THIS_MODULE;
> #endif
> 
> but as this doesn't seem to be the favorite approach from people on
> the mailing list, I'll leave this one to people in charge of
> the module to apply the best approach patch to fix this.
> 
> Please note that, however, I've tested this change, and it is 
> working fine on my machine.

Thanks for the raport, the proposed change is fine with me. Care to
generate a real patch?

-- 
Jens Axboe

