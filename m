Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263826AbUE1UK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263826AbUE1UK3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 16:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbUE1UK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 16:10:29 -0400
Received: from hera.cwi.nl ([192.16.191.8]:41620 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263826AbUE1UK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 16:10:28 -0400
Date: Fri, 28 May 2004 22:10:25 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Chris Osicki <osk@osk.ch>, linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040528201025.GA20662@apps.cwi.nl>
References: <20040525201616.GE6512@gucio> <20040528194136.GA5175@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528194136.GA5175@pclin040.win.tue.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 09:41:36PM +0200, Andries Brouwer wrote:

> > setkeycodes 71 101
> > 
> > # getkeycodes | grep 0x70
> >  0x70:   93 101   0  89   0   0  85  91
> 
> Your report is a bit messy. You change things for scancode 0x71 and then
> expect the keycode for 0x70 to be changed?

Sorry - replied too quickly.
Yes, so your setkeycodes worked fine.

> > But showkeys -s shows 0x5b when the key in question is pressed
> > (and no release event!!??)

Now you told the kernel that scancode 0x71 belongs to keycode 101.

Do you say that your key does not have scancode 0x71, but 0x5b?
The question remains: what is it under 2.4? what under 2.6?

Andries
