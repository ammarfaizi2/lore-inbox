Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbUDSOwn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 10:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbUDSOwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 10:52:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37090 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264426AbUDSOwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 10:52:41 -0400
Date: Mon, 19 Apr 2004 10:52:37 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Phy Prabab <phyprabab@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Question on forcing cache data to write out
In-Reply-To: <20040419011329.0b07b0ad.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0404191051450.14039-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004, Andrew Morton wrote:
> Phy Prabab <phyprabab@yahoo.com> wrote:

> > quickly, but once the system memory becomes filled,
> > mostly held in "cache", then my NFS performance drops.

> Setting dirty_background_ratio lower might smooth things out.

Hmmm, I wonder if the "system gets slower" thing could be
measured somehow (IO request queue filling up?) and used
as a way to self-tune pdflush a bit ?

I'll take a look ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

