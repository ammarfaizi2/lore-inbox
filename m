Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265934AbUAUM1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 07:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265935AbUAUM1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 07:27:47 -0500
Received: from ns.suse.de ([195.135.220.2]:52156 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265934AbUAUM1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 07:27:46 -0500
Date: Wed, 21 Jan 2004 13:27:44 +0100
From: Andi Kleen <ak@suse.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.1-mm4
Message-Id: <20040121132744.1094129f.ak@suse.de>
In-Reply-To: <20040121084009.GC295@ucw.cz>
References: <p73r7xwglgn.fsf@verdi.suse.de>
	<20040121043608.6E4BB2C0CB@lists.samba.org>
	<20040121084009.GC295@ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jan 2004 09:40:09 +0100
Vojtech Pavlik <vojtech@suse.cz> wrote:

> 
> Inbetween the module changes and the input changes there was a
> situation, where you'd have to pass
> 
> 	psmouse.psmouse_maxproto=imps2
> 
> as a kernel argument. This should (I hope so, I have to check) be fixed
> now.

No, 2.6.1 requires it.

And worst is that you have to reboot to change mouse settings at all.
That just doesn't make any sense. Can you please add an runtime sysfs
interface for this?

-Andi
