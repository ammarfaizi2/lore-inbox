Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVAODhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVAODhC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 22:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVAODhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 22:37:02 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:49089 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262210AbVAODhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 22:37:00 -0500
Date: Sat, 15 Jan 2005 04:36:55 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Christoph Hellwig <hch@lst.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup virtual console <-> selection.c interface
In-Reply-To: <20041231143457.GA9165@lst.de>
Message-ID: <Pine.LNX.4.61.0501150431360.6118@scrub.home>
References: <20041231143457.GA9165@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 31 Dec 2004, Christoph Hellwig wrote:

> Pass around pointers instead of indices into a global array between
> various files of the virtual console implementation and stop using
> obsfucting macros that expect certain variables to be in scope.

I should really sent out my own patches faster. :)
I have three patches which take this a bit further and removes these 
macros completely and does some other small cleanups. It saves a bit more 
than 3KB.

bye, Roman
