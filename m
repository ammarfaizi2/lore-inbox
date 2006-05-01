Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWEAV3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWEAV3V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWEAV3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:29:20 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:30984 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932270AbWEAV3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:29:20 -0400
Date: Mon, 1 May 2006 23:29:19 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc3-mm1
Message-ID: <20060501212919.GA21191@mars.ravnborg.org>
References: <20060501014737.54ee0dd5.akpm@osdl.org> <625fc13d0605010554l4cadac0fxe7fbc6cd5d57c679@mail.gmail.com> <20060501095913.13a74b2b.akpm@osdl.org> <e35lmt$1iv$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e35lmt$1iv$1@terminus.zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 11:57:33AM -0700, H. Peter Anvin wrote:
 
> If it makes your life easier I'd be happy to produce a klibc tree on
> top of the header cleanup tree.
klibc is independent today and I really suggest to leave it so until
header cleanup tree has been merged.
Otherwise we would end up in a situation where klibc are ready but due
to dependency on header cleanup we had to wait until 2.6.19.

> klibc really should be built against
> the exported headers, which should both make klibc easier to maintain
> and provide a degree automatic testing of the exported headers.
So this is a natural next step on top of the header cleanup tree.

	Sam
