Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268619AbTCCVno>; Mon, 3 Mar 2003 16:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268625AbTCCVnn>; Mon, 3 Mar 2003 16:43:43 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:49057 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S268619AbTCCVni>; Mon, 3 Mar 2003 16:43:38 -0500
Date: Mon, 3 Mar 2003 13:53:56 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
Message-ID: <20030303215356.GE2835@ca-server1.us.oracle.com>
References: <200303020011.QAA13450@adam.yggdrasil.com> <3E615C38.7030609@pobox.com> <20030302014039.GC1364@dualathlon.random> <3E616224.6040003@pobox.com> <b3rtr2$rmg$1@cesium.transmeta.com> <3E623B9A.8050405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E623B9A.8050405@pobox.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 12:12:58PM -0500, Jeff Garzik wrote:
> My counter-question is, why not improve an _existing_ open source SCM to 
> read and write BitKeeper files?  Why do we need yet another brand new 
> project?

	Normally, I'd agree with you Jeff.  However, none of the current
open source SCM systems are architected in a way that can operate like
BK.
	I've been using subversion for a while now.  It pretty much
fixes all the problems that CVS had, AS LONG AS you accept the CVS style
of version control.  That style doesn't work for non-central work like
the kernel.
	The one thing BK does that makes it worthwhile is the three-way
merge.  This (and the resulting DAG) make handling code from Alan, from
Linus, from Andrew, and from everyone else possible.  With CVS,
subversion, or any other SCM I've worked with, you have to hand merge
anything past the first patch.  Ugh.
	This requires architecture, and (AFAIK) BitBucket is the first
try at it.  Compatibility with the proprietary tool that does it already
is a good thing.

Joel


-- 

"Can any of you seriously say the Bill of Rights could get through
 Congress today?  It wouldn't even get out of committee."
	- F. Lee Bailey

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
