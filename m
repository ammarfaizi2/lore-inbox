Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWDRXTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWDRXTM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 19:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWDRXTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 19:19:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2280 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750786AbWDRXTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 19:19:10 -0400
Date: Wed, 19 Apr 2006 00:19:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060418231909.GA2964@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	fireflier-devel@lists.sourceforge.net
References: <Pine.LNX.4.64.0604181709160.28128@d.namei> <20060418231657.68869.qmail@web36613.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418231657.68869.qmail@web36613.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 04:16:57PM -0700, Casey Schaufler wrote:
> 
> 
> --- James Morris <jmorris@namei.org> wrote:
> 
> 
> > No.  The inode design is simply correct.
> 
> If this were true audit records would not be required
> to contain path names. Names are important. To meet
> EAL requirements path names are demonstrably
> insufficient, but so too are inode numbers. Unless
> you want to argue that Linux is unevaluateable
> (a pretty tough position to defend) because it
> requires both in an audit record you cannot claim
> either is definitive.

Sure you can log the pathname to comply with useless
standards.  It doesn't make it any more meaningfull,
though.
