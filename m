Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVKUIbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVKUIbi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 03:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVKUIbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 03:31:38 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:29161
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932222AbVKUIbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 03:31:37 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC] userland swsusp
Date: Mon, 21 Nov 2005 00:23:51 -0600
User-Agent: KMail/1.8
Cc: Stefan Rompf <stefan@loplof.de>, linux-kernel@vger.kernel.org
References: <200511161700.27239.stefan@loplof.de> <20051116190715.GF2193@spitz.ucw.cz>
In-Reply-To: <20051116190715.GF2193@spitz.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511210023.51457.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 November 2005 13:07, Pavel Machek wrote:
> > I'm curious on the restrictions the userspace part would have to accept.
> > Can /usr/swsusp.c write to a file? Currently, you allow it, but I doubt
>
> No. Writing to file would trash the filesystem. But you can bmap the file,
> then write to the block device.

Do/should all the filesystems get remounted read-only as a precaution?  Or is 
that overkill?

Rob
