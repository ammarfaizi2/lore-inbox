Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264666AbSIWBUr>; Sun, 22 Sep 2002 21:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264674AbSIWBUr>; Sun, 22 Sep 2002 21:20:47 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:6161 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S264666AbSIWBUr>; Sun, 22 Sep 2002 21:20:47 -0400
Date: Mon, 23 Sep 2002 02:25:57 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.38-mm1
Message-ID: <20020923012557.GA69900@compsoc.man.ac.uk>
References: <3D8D5F2A.BC057FC4@digeo.com> <20020923004036.GA13921@www.kroptech.com> <3D8E6647.8B02E613@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8E6647.8B02E613@digeo.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 05:54:31PM -0700, Andrew Morton wrote:

> It found a bug.  Someone is calling kmem_cache_create() in an
> atomic region.

And kmem_cache_alloc() has jumped to the top of the profile (checked
with readprofile) in 2.3.38-linus.

Didn't bother looking why ...

regards
john

-- 
"Say what you mean or you won't mean a thing to me."
        - Embrace
