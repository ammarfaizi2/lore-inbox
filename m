Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbUCOQRV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 11:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbUCOQRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 11:17:19 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:43242 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262698AbUCOQNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 11:13:40 -0500
Date: Mon, 15 Mar 2004 17:13:23 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Ian Kent <raven@themaw.net>
Cc: Carsten Otte <cotte@freenet.de>, linux-kernel@vger.kernel.org,
       mszeredi@inf.bme.hu, herbert@13thfloor.at
Subject: Re: unionfs
Message-ID: <20040315161323.GD16615@wohnheim.fh-wedel.de>
References: <200403151235.25877.cotte@freenet.de> <20040315121934.GB16615@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0403152045290.14862@raven.themaw.net> <20040315131601.GC16615@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0403152233490.19386@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0403152233490.19386@raven.themaw.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 March 2004 22:35:20 +0800, Ian Kent wrote:
> 
> I don't understand the requirement properly. Sorry.

Depends on who you ask, but imo it boils down to this:
- Use one filesystem as backing store, usually ro.
- Have another filesystem on top for extra functionality, usually rw
  access.

Famous example is a rw-CDROM, where writes go to hard drive and
unchanged data is read from CDROM.  But it makes sense for other
things as well.

Jörn

-- 
Data expands to fill the space available for storage.
-- Parkinson's Law
