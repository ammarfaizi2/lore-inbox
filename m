Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbUAUIkJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 03:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265864AbUAUIkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 03:40:09 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:6272 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263803AbUAUIkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 03:40:05 -0500
Date: Wed, 21 Jan 2004 09:40:09 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.1-mm4
Message-ID: <20040121084009.GC295@ucw.cz>
References: <p73r7xwglgn.fsf@verdi.suse.de> <20040121043608.6E4BB2C0CB@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040121043608.6E4BB2C0CB@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 03:06:57PM +1100, Rusty Russell wrote:
> In message <p73r7xwglgn.fsf@verdi.suse.de> you write:
> > Rusty Russell <rusty@rustcorp.com.au> writes:
> > 
> > > Migrating to module_param() is the Right Thing here IMHO, which actually
> > > takes the damn address,
> > 
> > The main problem is that module_parm renames the boot time arguments and
> > makes them long and hard to remember.
> 
> Um, if the module name is neat, and the parameter name is neat, the
> combination of the two with a "."  between them will be nest.
> 
> > E.g. the new argument needed to make the mouse work on KVMs is
> > mindboogling, could be nearly a Windows registry entry.
> 
> I have no idea what you are talking about. 8(

Inbetween the module changes and the input changes there was a
situation, where you'd have to pass

	psmouse.psmouse_maxproto=imps2

as a kernel argument. This should (I hope so, I have to check) be fixed
now.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
