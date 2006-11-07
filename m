Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753860AbWKGANr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860AbWKGANr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 19:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753863AbWKGANq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 19:13:46 -0500
Received: from nz-out-0102.google.com ([64.233.162.193]:27456 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1753860AbWKGANp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 19:13:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=budG7z4V9QMASNjb6qaANl32uk08tR0eAx3+wTiqHRqCc/0tqrdKXdLGtzFvmjrP+w0EHdwS5HMj9wawXo/mhzFHsglWBVgoLyohx6cV73RQcJ1Z7yaUj6aXwCleuJWDMw3pV289hXKlTHI1Pf7riE40ZxlEZLCIReECpl3+5ck=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Andreas Dilger'" <adilger@clusterfs.com>,
       "'Eric Sandeen'" <sandeen@redhat.com>
Cc: "'Christoph Hellwig'" <hch@infradead.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'linux-fsdevel'" <linux-fsdevel@vger.kernel.org>,
       "'Theodore Tso'" <tytso@mit.edu>
Subject: RE: [RFC/PATCH] - revert generic_fillattr stat->blksize to PAGE_CACHE_SIZE
Date: Mon, 6 Nov 2006 16:13:39 -0800
Message-ID: <015301c70201$94e88e00$0200a8c0@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20061107000840.GF6012@schatzie.adilger.int>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AccCAUKpPCEodFdbRfCHYc6valPbLQAAD7+w
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, rather than blindly revert to pre-patch behaviour 
> it would be worthwhile to determine if PAGE_SIZE isn't the 
> better value.  In some cases people don't understand that 
> i_blksize is the "optimal IO size"
> and instead assume it is the filesystem blocksize.  I saw a 
> few that were e.g. 512 and that can't be very useful.

Of course the name i_blksize is very clear on that. :-)
 
> Cheers, Andreas
> --
> Andreas Dilger
> Principal Software Engineer
> Cluster File Systems, Inc.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

