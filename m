Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbTINRkj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 13:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbTINRkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 13:40:39 -0400
Received: from ns.suse.de ([195.135.220.2]:36502 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261210AbTINRki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 13:40:38 -0400
Date: Sun, 14 Sep 2003 19:40:17 +0200
From: Karsten Keil <kkeil@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: isdn4linux@listserv.isdn4linux.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test5: ISDN kcapi.c no longer compiles
Message-ID: <20030914174017.GA28240@pingi3.kke.suse.de>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	isdn4linux@listserv.isdn4linux.de,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org> <20030910165742.GG27368@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910165742.GG27368@fs.tum.de>
User-Agent: Mutt/1.4i
Organization: SuSE Linux AG
X-Operating-System: Linux 2.4.21-58-default i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Wed, Sep 10, 2003 at 06:57:42PM +0200, Adrian Bunk wrote:
> On Mon, Sep 08, 2003 at 01:32:05PM -0700, Linus Torvalds wrote:
> >...
> > Summary of changes from v2.6.0-test4 to v2.6.0-test5
> > ============================================
> >...
> > Karsten Keil:
> >...
> >   o next fixes
> >...
> 
> It seems this change broke the compilation of kcapi.c:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/isdn/capi/kcapi.o
> drivers/isdn/capi/kcapi.c: In function `capi_ctr_get':
> drivers/isdn/capi/kcapi.c:82: error: dereferencing pointer to incomplete type
> drivers/isdn/capi/kcapi.c: In function `capi_ctr_put':
> drivers/isdn/capi/kcapi.c:90: error: dereferencing pointer to incomplete type
> make[3]: *** [drivers/isdn/capi/kcapi.o] Error 1
> 
> <--  snip  -->
> 
> cu
> Adrian

I checked it with test5 and test5-bk3, no error here, so it seems that it
depends on your .config.
Please send me your .config in a PM.


-- 
Karsten Keil
SuSE Labs
ISDN development
