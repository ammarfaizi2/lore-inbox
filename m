Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWFAVvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWFAVvI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWFAVvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:51:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:53869 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750744AbWFAVvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:51:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FcHGyHl/zB1tb01sIJzyJyF4HkhDMLaanX5tt+OcYB+A6TW304ei6JvTj1nViEBfAkebgWHcMk+CCDW6oWM+wsru9pFEMvsTKNFzeaRiYtQ+upQL67ysdW214oWcTU5nbxZ6NLXts3QeF63IL9pPUr6B66O4UpP+gHLrXS+HTJI=
Message-ID: <9a8748490606011451m69e2f437uf3822e535f87d9ae@mail.gmail.com>
Date: Thu, 1 Jun 2006 23:51:05 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060601014806.e86b3cc0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060601014806.e86b3cc0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/
>
>

Got a few build warnings with this one :

drivers/scsi/scsi_tgt_lib.c: In function `scsi_tgt_cmd_destroy':
drivers/scsi/scsi_tgt_lib.c:111: warning: implicit declaration of
function `scsi_host_put_command'
drivers/scsi/scsi_tgt_lib.c: In function `scsi_tgt_init_cmd':
drivers/scsi/scsi_tgt_lib.c:334: warning: implicit declaration of
function `scsi_alloc_sgtable'
drivers/scsi/scsi_tgt_lib.c:334: warning: assignment makes pointer
from integer without a cast
drivers/scsi/scsi_tgt_lib.c:349: warning: implicit declaration of
function `scsi_free_sgtable'


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
