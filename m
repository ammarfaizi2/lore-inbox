Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422770AbWJRSdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422770AbWJRSdx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422771AbWJRSdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:33:53 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:23447 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1422770AbWJRSdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:33:52 -0400
Date: Wed, 18 Oct 2006 14:32:22 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 03/10] uml: fix prototypes
Message-ID: <20061018183222.GA6566@ccure.user-mode-linux.org>
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan> <20061017212709.26445.54420.stgit@americanbeauty.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061017212709.26445.54420.stgit@americanbeauty.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 11:27:09PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> Fix prototypes in user.h - was needed when including user.h in kernelspace, 
> as we did in previous patch.

user.h shouldn't be included in kernelspace - its purpose is to
provide kernel prototypes to userspace code.

				Jeff
