Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267808AbUHYEnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267808AbUHYEnN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 00:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268084AbUHYEnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 00:43:13 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:16788 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267808AbUHYEnK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 00:43:10 -0400
Date: Wed, 25 Aug 2004 06:43:52 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH] fix cc-version breakage
Message-ID: <20040825044351.GA7310@mars.ravnborg.org>
Mail-Followup-To: Jesse Barnes <jbarnes@engr.sgi.com>,
	linux-kernel@vger.kernel.org, sam@ravnborg.org
References: <200408241642.21886.jbarnes@engr.sgi.com> <200408241648.49261.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408241648.49261.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 04:48:49PM -0700, Jesse Barnes wrote:
> 
> Actually, this is a little nicer (look ma, no linewraps!) if we can make 
> gcc-version.sh executable.
It is no possible for all users to guarantee this, therefore the rule of thumb
for the kernel is to always use CONFIG_SHELL.

Btw - patch already sent to Linus and lkml.

	Sam
