Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbUJYIsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbUJYIsC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 04:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbUJYIpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 04:45:50 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:15095 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261715AbUJYInq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 04:43:46 -0400
Date: Mon, 25 Oct 2004 01:43:08 -0700
From: Chris Wedgwood <cw@f00f.org>
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 07/10] uml: kbuild - add even more cleaning
Message-ID: <20041025084308.GA19935@taniwha.stupidest.org>
References: <20041012001759.317908695@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012001759.317908695@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 02:17:59AM +0200, blaisorblade_spam@yahoo.it wrote:

>  MRPROPER_FILES += $(SYMLINK_HEADERS) $(ARCH_SYMLINKS) \
> -	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS))
> +	$(addprefix $(ARCH_DIR)/kernel/,$(KERN_SYMLINKS)) $(ARCH_DIR)/os

these sorts of rules don't work when doing "make O=build ARCH=um ..."
