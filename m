Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268578AbUIMRUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268578AbUIMRUK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 13:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268524AbUIMRUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 13:20:09 -0400
Received: from barclay.balt.net ([195.14.162.78]:17567 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S268578AbUIMRT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 13:19:27 -0400
Date: Mon, 13 Sep 2004 20:19:13 +0300
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 rc2 freezing
Message-ID: <20040913171912.GA24871@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <20040913165551.GA24135@gemtek.lt> <4145D4ED.6070403@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4145D4ED.6070403@pobox.com>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 01:12:13PM -0400, Jeff Garzik wrote:
> I'm totally blind, because I don't see your network driver in that big 
> list of modules.
> 
> Your network driver should probably be doing dev_kfree_skb_any() 
> somewhere, but isn't.
> 
> 	Jeff

it e100 network driver, compiled in. 
CONFIG_E100=y
CONFIG_E100_NAPI=y

@see http://www.gemtek.lt/~zilvinas/oops/

there are full boot logs for 2.6.9 rc1 and rc2.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
