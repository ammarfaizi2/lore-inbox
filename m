Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVCBXsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVCBXsb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVCBXov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:44:51 -0500
Received: from fire.osdl.org ([65.172.181.4]:22489 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261260AbVCBXnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:43:45 -0500
Date: Wed, 2 Mar 2005 15:44:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Lars Marowsky-Bree <lmb@suse.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <20050302225846.GK17584@marowsky-bree.de>
Message-ID: <Pine.LNX.4.58.0503021543430.25732@ppc970.osdl.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
 <20050302225846.GK17584@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Mar 2005, Lars Marowsky-Bree wrote:
> 
> If the users wouldn't even have to know, why do it? Who will benefit
> from this, then?

They don't _have_ to know. But both users and developers can take 
advantage of this to time their patches.

> I think a better approach, and one which is already working out well in
> practice, is to put "more intrusive" features into -mm first, and only
> migrate them into 2.6.x when they have 'stabilized'.

That wouldn't change. But we still have the issue of "they have to be 
released sometime". This makes it clear to everybody when to merge, and 
when to calm down.

		Linus
