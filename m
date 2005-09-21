Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbVIUU5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbVIUU5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 16:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbVIUU5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 16:57:38 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:12296 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S964829AbVIUU5i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 16:57:38 -0400
Date: Wed, 21 Sep 2005 16:50:28 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [PATCH 06/10] uml: run mconsole "sysrq" in process context
Message-ID: <20050921205028.GB9918@ccure.user-mode-linux.org>
References: <200509211923.21861.blaisorblade@yahoo.it> <20050921172857.10219.71071.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050921172857.10219.71071.stgit@zion.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 07:28:57PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> Things are breaking horribly with sysrq called in interrupt context. I want to
> try to fix it, but probably this is simpler. To tell the truth, sysrq is
> normally run in interrupt context, so there shouldn't be any problem.

How are they breaking?

				Jeff
