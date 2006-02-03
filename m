Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWBCU2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWBCU2W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWBCU2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:28:22 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:55722 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751291AbWBCU2V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:28:21 -0500
From: Ismail Donmez <ismail@uludag.org.tr>
Organization: TUBITAK/UEKAE
To: Peter Osterlund <petero2@telia.com>
Subject: Re: [PATCH 2/5] pktcdvd: Remove version string
Date: Fri, 3 Feb 2006 22:29:28 +0200
User-Agent: KMail/1.9.1
References: <m3bqxoci5g.fsf@telia.com> <m37j8cci2r.fsf@telia.com>
In-Reply-To: <m37j8cci2r.fsf@telia.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602032229.28499.ismail@uludag.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cuma 3 Şubat 2006 22:18 tarihinde şunları yazmıştınız:
> The version information is not useful for a driver that is maintained
> in Linus' kernel tree.
>
> Signed-off-by: Peter Osterlund <petero2@telia.com>
> ---
>
>  drivers/block/pktcdvd.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> index f0a0ad4..01f070a 100644
> --- a/drivers/block/pktcdvd.c
> +++ b/drivers/block/pktcdvd.c
> @@ -43,8 +43,6 @@
>   *
>  
> *************************************************************************/
>
> -#define VERSION_CODE	"v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and
> petero2@telia.com" -
>  #include <linux/pktcdvd.h>
>  #include <linux/config.h>
>  #include <linux/module.h>
> @@ -2679,7 +2677,6 @@ static int __init pkt_init(void)
>
>  	pkt_proc = proc_mkdir("pktcdvd", proc_root_driver);
>
> -	DPRINTK("pktcdvd: %s\n", VERSION_CODE);
>  	return 0;
>
>  out:

Hmm this is useful to do dmesg|grep pktcdvd though when you compile it in the 
kernel. So I would like to keep it in.

Just my 2 cents.

Regards,
ismail
