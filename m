Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269747AbTHBRXt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 13:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269900AbTHBRXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 13:23:49 -0400
Received: from mail.kroah.org ([65.200.24.183]:58554 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269747AbTHBRXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 13:23:48 -0400
Date: Sat, 2 Aug 2003 10:18:34 -0700
From: Greg KH <greg@kroah.com>
To: Frank Aune <faune@stud.ntnu.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2: Badness in pci_find_subsys at drivers/pci/search.c:132
Message-ID: <20030802171834.GB11372@kroah.com>
References: <200308021223.48920.faune@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308021223.48920.faune@stud.ntnu.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 12:23:48PM +0200, Frank Aune wrote:
> 
> Seems to me the problem is related to every kernel devs "favourite" binary 
> driver; nvidia. Its version 4496 if that matters... Let me know if you need 
> more information.

Yes, this is a nvidia binary driver issue, nothing any of us kernel
developers can do about it, sorry.

And it's just a "warning", and is not a kernel oops.  This should not
have killed your box at all (but as the code you were using is closed
source, I might be completely wrong...)

Take it up with nvidia please.

thanks,

greg k-h
