Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275372AbTHGObk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275373AbTHGObk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:31:40 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:34435 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S275372AbTHGObi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:31:38 -0400
Subject: Re: Linux 2.4.22-pre10-ac1 DRI doesn't work with
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Mitch@0Bits.COM,
       Erik Andersen <andersen@codepoet.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030807142624.GA29208@lst.de>
References: <1060256649.3169.20.camel@dhcp22.swansea.linux.org.uk>
	 <Pine.LNX.4.44.0308071023040.6818-200000@logos.cnet>
	 <20030807142624.GA29208@lst.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060266450.3169.57.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Aug 2003 15:27:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-07 at 15:26, Christoph Hellwig wrote:
> > Anyway, Mitch (or Erik who's seeing the problem), can please revert the
> > vmap() change to check if its causing the mentioned problem? 
> 
> vmap() doesn't break DRM.  The external drm code just detects that
> vmap is present and then uses the new interface, but this new code
> also expects a new exported symbol.
> 
> The DRM code in your tree is completly unaffected.

Cool. So its a non issue for people not using the XFree CVS

