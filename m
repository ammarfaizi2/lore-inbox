Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266369AbUBEVeL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266530AbUBEVcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:32:35 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62397 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266369AbUBEVcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:32:00 -0500
Date: Thu, 5 Feb 2004 22:31:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Message-ID: <20040205213158.GI11683@suse.de>
References: <20040205212417.GI10547@stud.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205212417.GI10547@stud.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05 2004, Thomas Glanzmann wrote:
> Hi,
> 
> > Okay, we may be dealing with the buggy hardware at this point. Would
> > it make sense to tell the drive to flush it caches? If there's no
> > other possibility, we might want cdrecord to reset drive at the end of
> > blank and/or to make it eject...
> 
> It's not the drive, it's the kernel. We have to tell the kernel to
> *flush* *it's* buffers when doing an umount. See my other posting.

Partly, I still think the drive should report media changed after
knowingly doing a TOC blank (or change). But see my other post, should
work.

-- 
Jens Axboe

