Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVALPuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVALPuc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 10:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVALPuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 10:50:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:13478 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261235AbVALPuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 10:50:25 -0500
Date: Wed, 12 Jan 2005 07:50:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Brice.Goglin@ens-lyon.org, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Christoph Hellwig <hch@infradead.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11-rc1
In-Reply-To: <41E4DEBB.90606@ens-lyon.fr>
Message-ID: <Pine.LNX.4.58.0501120739130.2373@ppc970.osdl.org>
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
 <41E4DEBB.90606@ens-lyon.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jan 2005, Brice Goglin wrote:
> 
> setkeycodes does not work anymore on my Compaq Evo N600c running a Debian testing.
> 
> puligny:~# setkeycodes e023 150 e01e 155 e01a 217 e01f 157
> KDSETKEYCODE: No such device
> failed to set scancode a3 to keycode 150

Interesting. Vojtech - does this ring any bells? 

Afaik, nothing has changed in KDESTKEYCODE, the thing that comes closest 
is a change to some parameter calling in the vt layer by Christoph.

Input layer?

		Linus
