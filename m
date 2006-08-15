Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965250AbWHOT1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965250AbWHOT1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965380AbWHOT1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:27:20 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:12444 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S965250AbWHOT1S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:27:18 -0400
Subject: Re: [2.6 patch] orinoco.h: "extern inline" -> "static
	__always_inline"
From: Pavel Roskin <proski@gnu.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: hermes@gibson.dropbear.id.au, orinoco-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linville@tuxdriver.com, jgarzik@pobox.com
In-Reply-To: <20060815004046.GC3543@stusta.de>
References: <20060815004046.GC3543@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Aug 2006 15:26:33 -0400
Message-Id: <1155669993.2063.4.camel@dv>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 02:40 +0200, Adrian Bunk wrote:
> "extern inline" generates a warning with -Wmissing-prototypes and I'm 
> currently working on getting the kernel cleaned up for adding this to 
> the CFLAGS since it will help us to avoid a nasty class of runtime 
> errors.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Thanks for the patch!  I'm removing the last sentence in the comment as
irrelevant and fixing the comment.  The patch is being sent to netdev by
StGIT, cc: author.

-- 
Regards,
Pavel Roskin


