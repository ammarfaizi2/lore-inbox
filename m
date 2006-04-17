Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWDQRdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWDQRdW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 13:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWDQRdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 13:33:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7911 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751169AbWDQRdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 13:33:21 -0400
Date: Mon, 17 Apr 2006 18:33:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Christoph Hellwig <hch@infradead.org>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060417173319.GA11506@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
	linux-security-module@vger.kernel.org,
	James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
	fireflier-devel@lists.sourceforge.net
References: <200604021240.21290.edwin@gurde.com> <200604072138.35201.edwin@gurde.com> <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil> <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 01:03:24PM -0400, Stephen Smalley wrote:
> > fact for access control purposes is fundamentally flawed.  We're not going
> > to add helpers or exports for it, I'd rather remove the ability to build
> > lsm hook clients modular completely.
> 
> Or, better, remove LSM itself ;)

Seriously that makes a lot of sense.  All other modules people have come up
with over the last years are irrelevant and/or broken by design.

