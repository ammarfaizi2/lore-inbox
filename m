Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbUCONQT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 08:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbUCONQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 08:16:19 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:52694 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262562AbUCONQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 08:16:17 -0500
Date: Mon, 15 Mar 2004 14:16:01 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Ian Kent <raven@themaw.net>
Cc: Carsten Otte <cotte@freenet.de>, linux-kernel@vger.kernel.org,
       mszeredi@inf.bme.hu, herbert@13thfloor.at
Subject: Re: unionfs
Message-ID: <20040315131601.GC16615@wohnheim.fh-wedel.de>
References: <200403151235.25877.cotte@freenet.de> <20040315121934.GB16615@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0403152045290.14862@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0403152045290.14862@raven.themaw.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 March 2004 20:47:05 +0800, Ian Kent wrote:
> On Mon, 15 Mar 2004, [iso-8859-1] Jörn Engel wrote:
> > 
> > You could also have some sort of 'hidden symlink', i.e. something that
> > behaves just like a file but is in fact a link to some other
> > filesystem.  If that other filesystem is not accessable, all
> > operations return -EIO.
> 
> Sounds a bit untidy.

If you have a cleaner idea, I'm open for suggestions.

> Has anyone checked http://www.filesystems.org/
> 
> What do you think?

Looks like an abstraction layer that still assumes a 1:1 mapping
between filesystems and devices, so it doesn't help.  Did I miss
something?

Jörn

-- 
And spam is a useful source of entropy for /dev/random too!
-- Jasmine Strong
