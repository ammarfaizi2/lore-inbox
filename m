Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbVGMVfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbVGMVfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 17:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVGMVeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 17:34:15 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:42080 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262457AbVGMVbh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 17:31:37 -0400
Date: Wed, 13 Jul 2005 23:19:30 +0000
From: Sam Ravnborg <sam@ravnborg.org>
To: randy_dunlap <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] scripts/kernel-doc: don't use uninitialized SRCTREE
Message-ID: <20050713231930.GB28514@mars.ravnborg.org>
References: <20050707153926.0673793b.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707153926.0673793b.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 03:39:26PM -0700, randy_dunlap wrote:
> 
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Current kernel-doc (perl) script generates this warning:
> Use of uninitialized value in concatenation (.) or string at scripts/kernel-doc line 1668.
> 
> so explicitly check for SRCTREE in the ENV before using it,
> and then if it is set, append a '/' to the end of it, otherwise
> the SRCTREE + filename can (will) be missing the intermediate '/'.

Applied,
	Sam
