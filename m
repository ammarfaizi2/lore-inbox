Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbVKRHK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbVKRHK4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 02:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbVKRHK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 02:10:56 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:20686
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932548AbVKRHK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 02:10:56 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [PATCH 2/4] UML - Eliminate anonymous union and clean up symlink lossage
Date: Fri, 18 Nov 2005 01:10:34 -0600
User-Agent: KMail/1.8
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200511172110.jAHLAQoe010199@ccure.user-mode-linux.org> <200511180103.29950.rob@landley.net>
In-Reply-To: <200511180103.29950.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511180110.35169.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 November 2005 01:03, Rob Landley wrote:
> On Thursday 17 November 2005 15:10, Jeff Dike wrote:
> > This gives a name to the anonymous union introduced in
> > skas-hold-own-ldt, allowing to build on a wider range of gccs.
>
> Or narrower range, in the case of Ubuntu "Horny Hedgehog".  2.6.15-rc1
> builds fine by itself, or with just patch 1 in this series, but with patch
> 2...

To clarify, 1, 3 and 4 in this series all build fine for me.  Only patch 2 is 
breaking my build.

Rob
