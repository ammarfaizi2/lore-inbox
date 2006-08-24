Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWHXRua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWHXRua (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWHXRua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:50:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35240 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030220AbWHXRua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:50:30 -0400
Subject: Re: [PATCH 1/4] Inconsistent extern declarations.
From: David Woodhouse <dwmw2@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20060824161344.GB5205@martell.zuzino.mipt.ru>
References: <1156429585.3012.58.camel@pmac.infradead.org>
	 <1156433118.3012.117.camel@pmac.infradead.org>
	 <20060824161344.GB5205@martell.zuzino.mipt.ru>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 18:50:25 +0100
Message-Id: <1156441825.3012.184.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 20:13 +0400, Alexey Dobriyan wrote:
> Better move proto to include/net/ipx.h since net/ipx/af_ipx.c already
> including it.
> 
> In general, this patch is wrong. Every external declaration and every
> proto should be in only one place. 

Yes, there's a lot of merit in that argument.

-- 
dwmw2

