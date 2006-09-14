Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWINULy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWINULy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWINULy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:11:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15543 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751115AbWINULx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:11:53 -0400
Subject: Re: [-mm patch 3/4] AVR32 MTD: Mapping driver for the ATSTK1000
	board
From: David Woodhouse <dwmw2@infradead.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060914163259.068abe6d@cad-250-152.norway.atmel.com>
References: <20060914162926.6c117b36@cad-250-152.norway.atmel.com>
	 <20060914163026.49766346@cad-250-152.norway.atmel.com>
	 <20060914163121.241dec3e@cad-250-152.norway.atmel.com>
	 <20060914163259.068abe6d@cad-250-152.norway.atmel.com>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 21:11:28 +0100
Message-Id: <1158264688.4312.82.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 16:32 +0200, Haavard Skinnemoen wrote:
> Add mapping driver for the AT49BV6416 NOR flash chip on the ATSTK1000
> development board. 

Hm, can't you set it up in advance and just register a platform_device
for physmap to drive?

-- 
dwmw2

