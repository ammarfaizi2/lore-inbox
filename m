Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbTDIQLq (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 12:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbTDIQLq (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 12:11:46 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:56846 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S262810AbTDIQLp (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 12:11:45 -0400
Date: Wed, 9 Apr 2003 18:23:20 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: what means duplicate "config" entries in Kconfig file?
In-Reply-To: <Pine.LNX.4.44.0304090826470.25330-100000@dell>
Message-ID: <Pine.LNX.4.44.0304091818470.12110-100000@serv>
References: <Pine.LNX.4.44.0304090826470.25330-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Apr 2003, Robert P. J. Day wrote:

>   [i just tried to email the Kconfig maintainer, but sendmail
> suggested that that mail might not have gotten through, so i'll
> toss this out here.]

I did already answer privately, but in case anyone is interested in the 
answer...

>   i'm not sure what it means to have two config entries with 
> identical symbols.  can someone clarify this?  i'm just confused
> (which should not come as a surprise at this point).

You can have as much entries as you want, the only limit is that you can
only have one user prompt per config entry and the type must not conflict.
This example could have been done with a single entry and this is usually
prefered to keep it more compact, but you don't have to.

> p.s.  and i'm open to where i should be emailing those patches
> if this list is not the right place.

You can Cc: me if you want, but I can mostly only comment on technical 
aspects. The subsystem/driver maintainer has the final decision.

bye, Roman

