Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264627AbSKDCl0>; Sun, 3 Nov 2002 21:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbSKDCl0>; Sun, 3 Nov 2002 21:41:26 -0500
Received: from holomorphy.com ([66.224.33.161]:57489 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264627AbSKDClZ>;
	Sun, 3 Nov 2002 21:41:25 -0500
Date: Sun, 3 Nov 2002 18:46:31 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Miles Bader <miles@gnu.org>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Jeff Garzik <jgarzik@pobox.com>, Jos Hulzink <josh@stack.nl>
Subject: Re: Petition against kernel configuration options madness...
Message-ID: <20021104024631.GU23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org,
	Vojtech Pavlik <vojtech@suse.cz>, Jeff Garzik <jgarzik@pobox.com>,
	Jos Hulzink <josh@stack.nl>
References: <20021103193734.GC2516@pasky.ji.cz> <200211031809.45079.josh@stack.nl> <3DC56270.8040305@pobox.com> <20021103200704.A8377@ucw.cz> <87y98a6omx.fsf@tc-1-100.kawasaki.gol.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y98a6omx.fsf@tc-1-100.kawasaki.gol.ne.jp>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 11:43:18AM +0900, Miles Bader wrote:
> Keep in mind that All the World's Not a PC.  No doubt those options are
> enabled on the majority of kernels, by number, but linux supports many,
> many types of systems, and I'll bet on fair number of them, it doesn't
> make much sense to enable psaux mouse support!
> So ... instead of saying `default y' for these options, how about saying
> `default IM_ON_A_PC' where IM_ON_A_PC is defined somehow.  How, I don't
> know; it could be a separate config question in a very obvious place,
> perhaps itself having `default X86'.
> Perhaps this should really be two flags, one IM_ON_A_PC meaning `typical
> i386 pc with legacy devices', and the other, more general, being
> something like IM_ON_A_WORKSTATION.  Then wierd things like psaux would
> say `default IM_ON_A_PC', but more general things like keyboards would
> say `default IM_ON_A_WORKSTATION'.
> [Yeah, those names are sucky, I know...]
> Thanks,
> -Miles

How about a PC subarch and turning them on by default for it?


Bill
