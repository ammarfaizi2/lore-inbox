Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVIJM1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVIJM1Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 08:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVIJM1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 08:27:24 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:3183 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1750790AbVIJM1X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 08:27:23 -0400
Date: Sat, 10 Sep 2005 14:28:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix split-include dependency
Message-ID: <20050910122855.GA18983@mars.ravnborg.org>
References: <431D81B80200007800023FBD@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431D81B80200007800023FBD@emea1-mh.id2.novell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 11:47:04AM +0200, Jan Beulich wrote:
> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)
> 
> Splitting of autoconf.h requires that split-include was built before,
> and
> needs to be-re-done when split-include changes. This dependency was
> previously missing. Additionally, since autoconf.h is (suppoosed to
> be)
> generated as a side effect of executing config targets, include/linux
> should be created prior to running the respective sub-make.

Applied - thanks.

	Sam
