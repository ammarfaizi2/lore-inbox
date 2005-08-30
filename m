Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVH3Wiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVH3Wiu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbVH3Wiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:38:50 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:43787 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932178AbVH3Wiu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:38:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tbha+IYxiVBvGr0Ro4R4tTqbp16Hl0JYj80LapN97PUZ+iBul+LLSaY55eoAbkOcwNZGUYnebmjEzFqlbbkGNwVKYkt7KyYiwap9yF1YoG2nQrLfStQNh0Iwf5NRRl1JWCE2CKVYNW3MPTfOdX288IYUE4tYQFX1ya4tA0G955Y=
Message-ID: <21d7e99705083015388794017@mail.gmail.com>
Date: Wed, 31 Aug 2005 08:38:40 +1000
From: Dave Airlie <airlied@gmail.com>
To: David Reveman <davidr@novell.com>
Subject: Re: State of Linux graphics
Cc: Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>
In-Reply-To: <1125422813.20488.43.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e47339105083009037c24f6de@mail.gmail.com>
	 <1125422813.20488.43.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> As the author of Xgl and glitz I'd like to comment on a few things.
> 
> >From the article:
> 
> > Xgl was designed as a near term transition solution. The Xgl model
> > was to transparently replace the drawing system of the existing
> > X server with a compatible one based on using OpenGL as a device
> > driver. Xgl maintained all of the existing X APIs as primary APIs.
> > No new X APIs were offered and none were deprecated.
> ..
> > But Xgl was a near term, transition design, by delaying demand for
> > Xgl the EXA bandaid removes much of the need for it.
> 
> I've always designed Xgl to be a long term solution. I'd like if
> whatever you or anyone else see as not long term with the design of Xgl
> could be clarified.

I sent this comment to Jon before he published:
"Xgl was never near term, maybe you thought it was but no-one else did, the
sheer amount of work to get it to support all the extensions the current X
server does would make it non-near term ..."

I believe he is the only person involved who considered it near term,
without realising quite how much work was needed...

Dave.
