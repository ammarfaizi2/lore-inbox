Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWFXVyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWFXVyG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 17:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWFXVyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 17:54:05 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:35492 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964851AbWFXVyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 17:54:00 -0400
Date: Sat, 24 Jun 2006 23:54:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, Jon Masters <jcm@redhat.com>
Subject: Re: [RFC PATCH] kbuild support for %.symtypes files
Message-ID: <20060624215400.GC8904@mars.ravnborg.org>
References: <200605092037.31228.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605092037.31228.agruen@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 08:37:30PM +0200, Andreas Gruenbacher wrote:
> Hello,
> 
> here is a patch that adds a new -T option to genksyms for generating dumps of 
> the type definition that makes up the symbol version hashes. This allows to 
> trace modversion changes back to what caused them. The dump format is the 
> name of the type defined, followed by its definition (which is almost C):

Applid as is. But please take a closer look at the output format.
Making it human readable somewho is desireable - even it the parsing
needs a bit more effort then.

	Sam
