Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVDSTSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVDSTSh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 15:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVDSTSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 15:18:37 -0400
Received: from [205.233.219.253] ([205.233.219.253]:61421 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S261617AbVDSTR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 15:17:57 -0400
Date: Tue, 19 Apr 2005 15:13:28 -0400
From: Jody McIntyre <scjody@steamballoon.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: bcollins@debian.org, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/: remove unneeded EXPORT_SYMBOL's
Message-ID: <20050419191328.GJ1111@conscoop.ottawa.on.ca>
References: <20050417195706.GD3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050417195706.GD3625@stusta.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2005 at 09:57:07PM +0200, Adrian Bunk wrote:
> This patch removes unneeded EXPORT_SYMBOL's.

Didn't you already send something like this (with fewer removals, mind
you) in December?

http://marc.theaimsgroup.com/?l=linux1394-devel&m=110350765817261&w=2

Given the objections to your December patch, why should we accept this
one now?

Jody

> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/ieee1394/ieee1394_core.c |   16 ----------------
>  1 files changed, 16 deletions(-)
> 
> --- linux-2.6.12-rc2-mm3-full/drivers/ieee1394/ieee1394_core.c.old	2005-04-17 20:49:31.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/drivers/ieee1394/ieee1394_core.c	2005-04-17 20:57:34.000000000 +0200
> @@ -1225,9 +1225,7 @@
>  EXPORT_SYMBOL(hpsb_set_packet_complete_task);
>  EXPORT_SYMBOL(hpsb_alloc_packet);
>  EXPORT_SYMBOL(hpsb_free_packet);
> -EXPORT_SYMBOL(hpsb_send_phy_config);
>  EXPORT_SYMBOL(hpsb_send_packet);
> -EXPORT_SYMBOL(hpsb_send_packet_and_wait);
>  EXPORT_SYMBOL(hpsb_reset_bus);
>  EXPORT_SYMBOL(hpsb_bus_reset);
>  EXPORT_SYMBOL(hpsb_selfid_received);
> @@ -1246,9 +1244,6 @@
>  EXPORT_SYMBOL(hpsb_make_lock64packet);
>  EXPORT_SYMBOL(hpsb_make_phypacket);
>  EXPORT_SYMBOL(hpsb_make_isopacket);
> -EXPORT_SYMBOL(hpsb_read);
> -EXPORT_SYMBOL(hpsb_write);
> -EXPORT_SYMBOL(hpsb_lock);
>  EXPORT_SYMBOL(hpsb_packet_success);
>  
>  /** highlevel.c **/
> @@ -1265,8 +1260,6 @@
>  EXPORT_SYMBOL(hpsb_set_hostinfo_key);
>  EXPORT_SYMBOL(hpsb_get_hostinfo_bykey);
>  EXPORT_SYMBOL(hpsb_set_hostinfo);
> -EXPORT_SYMBOL(highlevel_add_host);
> -EXPORT_SYMBOL(highlevel_remove_host);
>  EXPORT_SYMBOL(highlevel_host_reset);
>  
>  /** nodemgr.c **/
> @@ -1275,7 +1268,6 @@
>  EXPORT_SYMBOL(hpsb_register_protocol);
>  EXPORT_SYMBOL(hpsb_unregister_protocol);
>  EXPORT_SYMBOL(ieee1394_bus_type);
> -EXPORT_SYMBOL(nodemgr_for_each_host);
>  
>  /** csr.c **/
>  EXPORT_SYMBOL(hpsb_update_config_rom);
> @@ -1312,19 +1304,11 @@
>  EXPORT_SYMBOL(hpsb_iso_recv_flush);
>  
>  /** csr1212.c **/
> -EXPORT_SYMBOL(csr1212_create_csr);
> -EXPORT_SYMBOL(csr1212_init_local_csr);
> -EXPORT_SYMBOL(csr1212_new_immediate);
>  EXPORT_SYMBOL(csr1212_new_directory);
> -EXPORT_SYMBOL(csr1212_associate_keyval);
>  EXPORT_SYMBOL(csr1212_attach_keyval_to_directory);
> -EXPORT_SYMBOL(csr1212_new_string_descriptor_leaf);
>  EXPORT_SYMBOL(csr1212_detach_keyval_from_directory);
>  EXPORT_SYMBOL(csr1212_release_keyval);
> -EXPORT_SYMBOL(csr1212_destroy_csr);
>  EXPORT_SYMBOL(csr1212_read);
> -EXPORT_SYMBOL(csr1212_generate_csr_image);
>  EXPORT_SYMBOL(csr1212_parse_keyval);
> -EXPORT_SYMBOL(csr1212_parse_csr);
>  EXPORT_SYMBOL(_csr1212_read_keyval);
>  EXPORT_SYMBOL(_csr1212_destroy_keyval);
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> mailing list linux1394-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux1394-devel

-- 
