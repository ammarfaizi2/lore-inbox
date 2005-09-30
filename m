Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbVI3O3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbVI3O3e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 10:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbVI3O3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 10:29:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34995 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030321AbVI3O3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 10:29:33 -0400
Date: Fri, 30 Sep 2005 07:29:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: New and bogus(!) warning produced by sparse.
In-Reply-To: <Pine.LNX.4.60.0509301459020.23217@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0509300727450.3378@g5.osdl.org>
References: <Pine.LNX.4.60.0509301459020.23217@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Sep 2005, Anton Altaparmakov wrote:
> 
> I just did a git pull on sparse and it produced a new and I believe 
> bogus warning when trying to assign a value to a bit field member.  The 
> warning is:

Thanks, that's indeed very bogus. 

I see why it happens, will fix sparse momentarily (btw, for sparse bugs, 
use "linux-sparse@vger.kernel.org" rather than LKML - since this is 
clearly not a kernel problem ;)

		Linus
