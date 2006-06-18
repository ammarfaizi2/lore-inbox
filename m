Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWFRKN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWFRKN5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 06:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWFRKN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 06:13:57 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:29656 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750908AbWFRKN5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 06:13:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FH5a2BbgaIfawfIM21WQ6syOhVoR3rvPrqKUINj1YnNng1PecNJsUJitmNVZfynyVX+S+C4M1XQdjVzPWDahWI818n9P2mc75DapTKGSdZMA3+ZmRd6VjPTUKHyOM2E+InweHbnwyHNgIHIPBX0moFrhmP2LQWM4n1eLuuhUbYg=
Message-ID: <b8bf37780606180313w19a572a0i657bd7d5d234aa3f@mail.gmail.com>
Date: Sun, 18 Jun 2006 06:13:56 -0400
From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
To: "Con Kolivas" <kernel@kolivas.org>
Subject: Re: [ck] [ckpatch][28/29] fs-fcache-v2.1.patch
Cc: "linux list" <linux-kernel@vger.kernel.org>,
       "ck list" <ck@vds.kolivas.org>
In-Reply-To: <200606181735.30466.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200606181735.30466.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/06, Con Kolivas <kernel@kolivas.org> wrote:
> A frontend cache for a block device. The purpose is to speedup a
> fairly random but repeated read work load, like the boot of a system.
>
> Signed-off-by: Jens Axboe <axboe@suse.de>
> ---
>  block/ll_rw_blk.c       |   11
>  drivers/block/Kconfig   |    6
>  drivers/block/Makefile  |    1
>  drivers/block/fcache.c  | 1475+++++++++++++++++++++++++++++++++++
>  fs/ext3/super.c         |   81 ++
>  include/linux/bio.h     |    9
>  include/linux/ext3_fs.h |   14
>  7 files changed, 1587 insertions(+), 10 deletions(-)

I'm looking forward to test this on a XFS root filesystem.

Thanks,
-- 
[]s,
André Goddard
