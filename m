Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVCCHww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVCCHww (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 02:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVCCHww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 02:52:52 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:19730 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261493AbVCCHwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 02:52:34 -0500
Date: Thu, 3 Mar 2005 08:52:20 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Philippe Troin <phil@fifi.org>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, linux@syskonnect.de
Subject: Re: 2.4.29 sk98lin patch for Asus K8W SE Deluxe
Message-ID: <20050303075220.GG30106@alpha.home.local>
References: <873bvdbtdt.fsf@ceramic.fifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873bvdbtdt.fsf@ceramic.fifi.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 02:00:30PM -0800, Philippe Troin wrote:
  
> +	/* Asus K8V Se Deluxe bugfix. Correct VPD content */
> +	/* MBo April 2004 */
> +	if( ((unsigned char)pAC->vpd.vpd_buf[0x3f] == 0x38) &&
> +	    ((unsigned char)pAC->vpd.vpd_buf[0x40] == 0x3c) &&
> +	    ((unsigned char)pAC->vpd.vpd_buf[0x41] == 0x45) ) {
> +		printk("sk98lin : humm... Asus mainboard with buggy VPD ? correcting data.\n");
                      ^^^^^
Please, could you put some KERN_XXX here to avoid a buggy message level ?

Willy

