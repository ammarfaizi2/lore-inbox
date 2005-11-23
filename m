Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbVKWSdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVKWSdY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVKWSdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:33:24 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:21913 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932156AbVKWSdX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:33:23 -0500
Date: Wed, 23 Nov 2005 19:33:57 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Bodo Eggert <7eggert@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Makefile: Add modules-collect target
Message-ID: <20051123183357.GB8336@mars.ravnborg.org>
References: <Pine.LNX.4.58.0511231915340.5759@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0511231915340.5759@be1.lrz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 07:29:37PM +0100, Bodo Eggert wrote:
> I frequently (but not frequently enough) compile kernels on one machine 
> that are to be used on another machine. If It needs modules, I will need a 
> way to collect all modules that need to be transfered into a directory.
> Usurally I'll want INSTALL_MOD_PATH=somedir make modules_install, but I
> keep forgetting the name of the variable. I suppose I'm not the only one.
> 
> Therefore I suggest a modules_collect target, which will collect all 
> modules into a single directory ready for being tared and transfered:

If you keep forgetting the variable name why not put the variable name
in the help instead of adding a new target?

	Sam

