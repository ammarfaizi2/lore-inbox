Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWDSHhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWDSHhE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 03:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWDSHhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 03:37:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56454 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750732AbWDSHhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 03:37:02 -0400
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
From: Arjan van de Ven <arjan@infradead.org>
To: Kurt Garloff <garloff@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Gerrit Huizenga <gh@us.ibm.com>,
       James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <20060418213833.GC5741@tpkurt.garloff.de>
References: <20060417225525.GA17463@infradead.org>
	 <E1FVfGt-0003Wy-00@w-gerrit.beaverton.ibm.com>
	 <20060418115819.GB8591@infradead.org>
	 <20060418213833.GC5741@tpkurt.garloff.de>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 09:36:51 +0200
Message-Id: <1145432211.3085.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Actually, I'm a bit worried about the discussion.
> When I chose Linux, it was about the freedom of choice.
> And we have a nice abstraction (LSM) that allows this freedom. 

While I agree with the "freedom" part, I would not call the LSM
abstraction "nice". It's not. Part of the reason for that is that there
weren't more "real" users, only "ghost" ones, so fixing the interface to
fit the users hasn't been done. "removing" LSM seems to be an attempt to
fit the interface to all real users at the time. Once there's > 1, the
fix can be different ;)

