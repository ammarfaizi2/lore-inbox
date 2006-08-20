Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751732AbWHTJhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbWHTJhc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 05:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbWHTJhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 05:37:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24251 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751720AbWHTJhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 05:37:32 -0400
Subject: Re: [mm patch] drm, minor fixes
From: Arjan van de Ven <arjan@infradead.org>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       airlied@linux.ie
In-Reply-To: <20060819231621.GF720@slug>
References: <20060813012454.f1d52189.akpm@osdl.org>
	 <20060819231621.GF720@slug>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 20 Aug 2006 11:37:06 +0200
Message-Id: <1156066626.23756.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-19 at 23:16 +0000, Frederik Deweerdt wrote:
> On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> > 
> Hi Andrew,
> 
> The following patch adds minor fixes to the drm code:
> - fix return values that are wrong (return E* instead of return -E*)

are you sure the callers of these don't wrap it inside a DRM_ERR()
macro ?



- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

