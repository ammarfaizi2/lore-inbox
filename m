Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423357AbWF1O1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423357AbWF1O1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423358AbWF1O1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:27:52 -0400
Received: from canuck.infradead.org ([205.233.218.70]:40133 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1423357AbWF1O1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:27:51 -0400
Subject: Re: [PATCH 2/7] mtd: Add map file for mpc83xx boards
From: David Woodhouse <dwmw2@infradead.org>
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: "'linux-mtd@lists.infradead.org'" <linux-mtd@lists.infradead.org>,
       linuxppc-dev@ozlabs.org,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       Chu hanjin-r52514 <Hanjin.Chu@freescale.com>,
       Yin Olivia-r63875 <Hong-Hua.Yin@freescale.com>,
       Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306E04FD3@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467306E04FD3@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 15:27:41 +0100
Message-Id: <1151504861.17134.39.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-28 at 22:23 +0800, Li Yang-r58472 wrote:
> Flash mapping file for MPC83xx MDS platforms.

I'm not accepting any more individual map drivers unless they're
absolutely necessary, which this one isn't.

Use a platform device and physmap. Or better still, extend physmap to
handle of_devices too and just stick the flash information in the device
tree.

-- 
dwmw2

