Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVFNTcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVFNTcW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 15:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVFNTcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 15:32:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:209 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261307AbVFNTcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 15:32:15 -0400
Date: Tue, 14 Jun 2005 20:32:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steve Lord <lord@xfs.org>
Cc: Prarit Bhargava <prarit@sgi.com>, "K.R. Foley" <kr@cybsft.com>,
       Andrew Morton <akpm@osdl.org>, pozsy@uhulinux.hu,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
Message-ID: <20050614193201.GA2730@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steve Lord <lord@xfs.org>, Prarit Bhargava <prarit@sgi.com>,
	"K.R. Foley" <kr@cybsft.com>, Andrew Morton <akpm@osdl.org>,
	pozsy@uhulinux.hu, linux-kernel@vger.kernel.org,
	rusty@rustcorp.com.au
References: <20050611150525.GI17639@ojjektum.uhulinux.hu> <42AB25E7.5000405@xfs.org> <20050611120040.084942ed.akpm@osdl.org> <42AEDCFB.8080002@xfs.org> <42AEF979.2000207@cybsft.com> <42AF080A.1000307@xfs.org> <42AF0FA2.2050407@cybsft.com> <42AF165E.1020702@xfs.org> <42AF2088.3090605@sgi.com> <42AF2FA1.7080403@xfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AF2FA1.7080403@xfs.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 02:27:29PM -0500, Steve Lord wrote:
> Thanks Prarit,
> 
> I updated mkinitrd from 4.1.18 to 4.2.15 and udev from 039 to 058.
> This appears to have cured it on my work machine, I will try the
> other box later.
> 
> Looking at Documentation/Changes, which appears to still be the
> official repository for required tool versions, it seems somewhat
> dated, and makes no mention of mkinitrd version requirements.

One of the reasons for that is that there is not generic mkinitrd.
Every distribution has it's own variant.

