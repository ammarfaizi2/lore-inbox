Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVCBXaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVCBXaE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVCBX10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:27:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:24449 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261322AbVCBXYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:24:08 -0500
Date: Wed, 2 Mar 2005 15:23:49 -0800
From: Greg KH <greg@kroah.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050302232349.GA9743@kroah.com>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302225846.GK17584@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302225846.GK17584@marowsky-bree.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 11:58:46PM +0100, Lars Marowsky-Bree wrote:
> 
> This could be improved: _All_ new features have to go through -mm first
> for a period (of whatever length) / one cycle. 2.6.x only directly picks
> up "obvious" bugfixes, and a select set of features which have ripened
> in -mm. 2.6.x-pre releases would then basically "only" clean up
> integration bugs.

This is the way things work today already.  The only exception being the
networking code, but hey, networking's always been special :)

thanks,

greg k-h
