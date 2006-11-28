Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755972AbWK1XW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755972AbWK1XW1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 18:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757874AbWK1XW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 18:22:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26796 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1757849AbWK1XWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 18:22:25 -0500
Subject: Re: [PATCH 2.6.15.4 rel.2 1/1] libata: add hotswap to sata_svw
From: David Woodhouse <dwmw2@infradead.org>
To: Martin Devera <devik@cdi.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, lkosewsk@gmail.com.jgarzik
In-Reply-To: <E1F9klH-0004Fg-00@devix>
References: <E1F9klH-0004Fg-00@devix>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 23:22:19 +0000
Message-Id: <1164756139.14595.37.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-16 at 16:09 +0100, Martin Devera wrote:
> From: Martin Devera <devik@cdi.cz>
> 
> Add hotswap capability to Serverworks/BroadCom SATA controlers. The
> controler has SIM register and it selects which bits in SATA_ERROR
> register fires interrupt.
> The solution hooks on COMWAKE (plug), PHYRDY change and 10B8B decode 
> error (unplug) and calls into Lukasz's hotswap framework.
> The code got one day testing on dual core Athlon64 H8SSL Supermicro 
> MoBo with HT-1000 SATA, SMP kernel and two CaviarRE SATA HDDs in
> hotswap bays.
> 
> Signed-off-by: Martin Devera <devik@cdi.cz>

What became of this?

-- 
dwmw2

