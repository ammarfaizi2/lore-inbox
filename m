Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129137AbRBVWYF>; Thu, 22 Feb 2001 17:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129554AbRBVWXz>; Thu, 22 Feb 2001 17:23:55 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:54799 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S129137AbRBVWXq>; Thu, 22 Feb 2001 17:23:46 -0500
Date: Thu, 22 Feb 2001 22:23:25 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: Robert Read <rread@datarithm.net>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use correct include dir for build tools
In-Reply-To: <20010222123940.A20319@tenchi.datarithm.net>
Message-ID: <Pine.LNX.4.10.10102222222180.5716-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2001, Robert Read wrote:

> Please apply one line patch to the top level Makefile.  This points
> the build tools at the correct linux include dir.

Or please don't, it's incorrect.

It breaks cross-compiling, and just generally wrong.  If your
system won't build without this, it's broken.

Matthew.

