Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265168AbUAOQcN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 11:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265169AbUAOQcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 11:32:13 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:58384 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S265168AbUAOQcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 11:32:11 -0500
Date: Thu, 15 Jan 2004 17:32:02 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Gerd Knorr <kraxel@bytesex.org>
cc: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v4l-05 add infrared remote support
In-Reply-To: <20040115152009.GB18322@bytesex.org>
Message-ID: <Pine.LNX.4.58.0401151730570.2530@serv>
References: <20040115115611.GA16266@bytesex.org> <Pine.LNX.4.58.0401151502320.27223@serv>
 <20040115152009.GB18322@bytesex.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Jan 2004, Gerd Knorr wrote:

> > Another possibility is to use select:
> >
> > # selected as needed
> > config VIDEO_IR
> > 	tristate
> >
> > config VIDEO_BT848
> > 	...
> > 	select VIDEO_IR
>
> I like that one more, but last time I tried it didn't work.
> Is support select in Linus tree now?

Yes, it should work, it was merged quite some time ago.

bye, Roman
