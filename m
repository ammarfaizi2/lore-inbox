Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWGEQ7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWGEQ7F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 12:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWGEQ7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 12:59:05 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:22691 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964899AbWGEQ7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 12:59:03 -0400
Date: Wed, 5 Jul 2006 18:58:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       bernds_cb1@t-online.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] FRV: Introduce asm-offsets for FRV arch
Message-ID: <20060705165845.GB11822@mars.ravnborg.org>
References: <20060705132409.31510.22698.stgit@warthog.cambridge.redhat.com> <20060705132419.31510.92219.stgit@warthog.cambridge.redhat.com> <20060705144138.GA26545@mars.ravnborg.org> <1152117585.2987.21.camel@pmac.infradead.org> <20060705164828.GA8196@mars.ravnborg.org> <1152118241.2987.23.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152118241.2987.23.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 05:50:41PM +0100, David Woodhouse wrote:
> On Wed, 2006-07-05 at 18:48 +0200, Sam Ravnborg wrote:
> > That will be bad for all out-of-tree stuff.
> > Now they have to track down if the kernel they build for
> > are before or after we stuffed in #error in config.h
> 
> No, they have to track down if the kernel they build for is before or
> after the inclusion of config.h became unnecessary. That was actually
> quite a while ago, wasn't it?
git log says it was:
Sun Oct 30 22:42:11 2005

	Sam
