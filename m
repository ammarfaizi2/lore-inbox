Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264032AbTIBWIg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 18:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264043AbTIBWIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 18:08:36 -0400
Received: from mail.kroah.org ([65.200.24.183]:57482 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264032AbTIBWIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 18:08:35 -0400
Date: Tue, 2 Sep 2003 15:05:44 -0700
From: Greg KH <greg@kroah.com>
To: James Clark <jimwclark@ntlworld.com>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: Re: Driver Model
Message-ID: <20030902220544.GA20265@kroah.com>
References: <Pine.LNX.4.44.0309021420570.5614-100000@cherise> <200309022244.55500.jimwclark@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309022244.55500.jimwclark@ntlworld.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 10:44:55PM +0100, James Clark wrote:
> 
> Would a more rigid 'plugin' interface and the concequent move from mainly 
> 'source' modules to binary 'plugins' (still with source-code available for 
> all to see) mean that (a) Kernel was smaller

No, we would have to support all versions of the APIs over time, making
the kernel larger and harder to maintain.

> (2) Had to be released/recompiled less 

No, release frequency would have nothing to do with this.

> (4) Was EVEN more stable and (4) 'plugins' were more portable across
> releases and easier to install ?

No.

> I love Linux but this seems to be holding it back...

Please read the FAQ and many discussions about this very topic in the
past in the archives for why the kernel does not have a stable API
within itself.

That being said, the ammount the API changes over time in a "stable"
kernel series is usually quite small.

I understand coming from the Windows world this seems odd, but after a
bit of time you will see why it is quite nice.

Good luck,

greg k-h
