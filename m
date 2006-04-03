Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWDCTYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWDCTYG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 15:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbWDCTYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 15:24:06 -0400
Received: from cantor2.suse.de ([195.135.220.15]:35477 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751044AbWDCTYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 15:24:04 -0400
From: Andi Kleen <ak@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] x86_64: fix CONFIG_REORDER
Date: Mon, 3 Apr 2006 21:23:59 +0200
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20060403185503.GA22440@mars.ravnborg.org>
In-Reply-To: <20060403185503.GA22440@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604032123.59518.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 April 2006 20:55, Sam Ravnborg wrote:
> Fix CONFIG_REORDER.
> Value of cflags-y was assined to CFLAGS before cflags-y was
> assinged the value used for CONFIG_REORDER.
> Use cflags-y for all CFLAGS options in the Makefile to avoid this
> happening again.

Applied. Thanks.
-Andi
