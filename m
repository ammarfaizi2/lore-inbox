Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312086AbSCTTsq>; Wed, 20 Mar 2002 14:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312082AbSCTTsh>; Wed, 20 Mar 2002 14:48:37 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:6568 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S312083AbSCTTsX>; Wed, 20 Mar 2002 14:48:23 -0500
Date: Wed, 20 Mar 2002 15:05:49 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: task_struct changes?
In-Reply-To: <61DB42B180EAB34E9D28346C11535A78062DA0@nocmail101.ma.tmpw.net>
Message-ID: <Pine.LNX.4.40.0203201502170.7618-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Holzrichter, Bruce wrote:

> p_pptr changed to parent and you could just swap them in the code,
>
> IE:
> task_struct->p_pptr would become task_struct->parent
>
> Not sure about the p_opptr, but I bet you'll find the same type of change.
>
> I found this on Sparc64 as well, if you grep the 2.5.7 patch file, you
> should be able to find p_opptr pretty quickly, I bet.
>
> Hope this helps..
>
> Bruce H.

Thanks it did help.

I guessed right, but just wanted to make sure.

And I found p_opptr became real_parent, if anyone else was wondering.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

