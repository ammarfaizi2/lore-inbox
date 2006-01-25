Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWAYJOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWAYJOx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 04:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWAYJOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 04:14:53 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:45157 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751066AbWAYJOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 04:14:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=QOyauS3rmdIsPi1N43qV9QbaN0VDeCcmQciRxtskgtZBemfqoNhQA0BZjXJy0s2Rgou2z/Q3dDauk/Jdvvi/nee7MU1H/VstihmuTx3SvIYEU3M29XY3PXNVdzbqRKBxIct6ic3tCMCtq6vNatkveTDKEtxnfTeY9wFPnXwBat4=
Date: Wed, 25 Jan 2006 12:32:24 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] s390: dasd_eckd: add missing }
Message-ID: <20060125093224.GC15301@mipter.zuzino.mipt.ru>
References: <20060124232406.50abccd1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124232406.50abccd1.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/s390/block/dasd_eckd.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1502,6 +1502,7 @@ dasd_eckd_ioctl(struct block_device *bde
 		return dasd_eckd_steal_lock(bdev, cmd, arg);
 	default:
 		return dasd_generic_ioctl(bdev, cmd, arg);
+	}
 }
 
 /*

