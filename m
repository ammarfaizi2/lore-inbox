Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262815AbVAQRB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbVAQRB2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 12:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbVAQRB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 12:01:28 -0500
Received: from lump.einval.com ([217.147.81.17]:11416 "EHLO mail.einval.com")
	by vger.kernel.org with ESMTP id S262815AbVAQRB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:01:26 -0500
From: Steve McIntyre <smcintyre@software.plasmon.com>
To: akpm@osdl.org
Subject: Re: [fuse-devel] Merging?
In-Reply-To: <20050112110109.6a21fae5.akpm@osdl.org>
References: <loom.20041231T155940-548@post.gmane.org> <E1ClQi2-0004BO-00@dorka.pomaz.szeredi.hu> <E1CoisR-0001Hi-00@dorka.pomaz.szeredi.hu> <E1CoisR-0001Hi-00@dorka.pomaz.szeredi.hu>
Organization: Invalid Argument
Cc: kinema@gmail.com, fuse-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Message-Id: <E1CqaFX-0006hp-V4@sledge.mossbank.org.uk>
Date: Mon, 17 Jan 2005 17:01:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>>  Well, there doesn't seem to be a great rush to include FUSE in the
>>  kernel.  Maybe they just don't realize what they are missing out on ;)
>
>heh.  What userspace filesystems have thus-far been developed, and what are
>people using them for?

At Plasmon we've developed a userland driver for our new UDO (Ultra
Density Optical) drive using FUSE. To avoid the complexity of
supporting a native 8KB sector size directly in kernel, we have
instead used FUSE to allow us to work on filesystems in
userland. That's made life _very_ much easier for us...

FUSE is very cool - there are many useful things that can be done with
it. Kudos to Miklos and others for their work on it!

-- 
Steve McIntyre, Plasmon                       smcintyre@software.plasmon.com
For more information on UDO, visit www.udo.com
