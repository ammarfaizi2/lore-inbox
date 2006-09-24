Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751632AbWIXIji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbWIXIji (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 04:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWIXIji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 04:39:38 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:62649 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1751590AbWIXIjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 04:39:37 -0400
Date: Sun, 24 Sep 2006 10:44:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Aron Griffis <aron@hp.com>, linux-kernel@vger.kernel.org,
       Masatake YAMATO <jet@gyve.org>
Subject: Re: Extend kbuild/defconfig tags support to exuberant ctags
Message-ID: <20060924084418.GB22289@uranus.ravnborg.org>
References: <20060921042659.GA32242@fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921042659.GA32242@fc.hp.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 12:27:02AM -0400, Aron Griffis wrote:
> The following patch extends kbuild/defconfig tags support to exuberant
> ctags.  The previous support is only for emacs ctags/etags programs.
> 
> This patch also corrects the kconfig regex for the emacs invocation.
> Previously it would miss some instances because it assumed /^config
> instead of /^[ \t]*config

Applied.
But may soon be tempted to factor all TAGS (tags, TAGS, cscope) support
out of top-level Makefile.

	Sam
