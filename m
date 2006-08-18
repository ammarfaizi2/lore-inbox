Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751517AbWHRWPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbWHRWPL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWHRWPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:15:11 -0400
Received: from mailout1.pacific.net.au ([61.8.0.84]:32437 "EHLO
	mailout1.pacific.net.au") by vger.kernel.org with ESMTP
	id S1751517AbWHRWPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:15:10 -0400
Date: Sat, 19 Aug 2006 08:12:56 +1000
From: Greg Schafer <gschafer@zip.com.au>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's in kbuild.git for 2.6.19
Message-ID: <20060818221256.GA23549@tigers.local>
References: <20060813194503.GA21736@mars.ravnborg.org> <pan.2006.08.18.08.26.03.994311@zip.com.au> <20060818171335.GA7595@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060818171335.GA7595@mars.ravnborg.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 07:13:35PM +0200, Sam Ravnborg wrote:
> On Fri, Aug 18, 2006 at 06:26:07PM +1000, Greg Schafer wrote:
> >   HOSTCC  scripts/unifdef
> > /tmp/ccwcmPxS.o: In function `keywordedit':
> > unifdef.c:(.text+0x25c): undefined reference to `strlcpy'
> > collect2: ld returned 1 exit status
> > make[1]: *** [scripts/unifdef] Error 1
> > make: *** [headers_install] Error 2
> 
> When I grep in the unifdef sources I get only one reference to strlcpy.
> That's a prototype that was missed when I replaced the use of strlcpy
> with a dedicated implementation.

Arghhh, I was cherry-picking patches and missed "replace use of strlcpy with
a dedicated implmentation in unifdef". Sorry for the noise..

Regards
Greg
