Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWAYAae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWAYAae (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 19:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWAYAad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 19:30:33 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:14281 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750912AbWAYAac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 19:30:32 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Date: Wed, 25 Jan 2006 01:31:58 +0100
User-Agent: KMail/1.9
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
References: <200601240929.37676.rjw@sisk.pl> <200601250053.27394.rjw@sisk.pl> <20060124161714.0118f1af.akpm@osdl.org>
In-Reply-To: <20060124161714.0118f1af.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601250131.59271.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 25 January 2006 01:17, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > IMHO after it gets into mainline every next version of the interface should
> > be backwards compatible with the previous one.
> 
> That's insufficient.  Every new version of the userspace tools also needs
> to be back-compatible with (and tested against!) older kernels.

Certainly.  I only referred to the "new kernel with old userland tools" case,
but it goes both ways.
