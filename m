Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263820AbUGZUza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263820AbUGZUza (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 16:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUGZUza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 16:55:30 -0400
Received: from agminet02.oracle.com ([141.146.126.229]:39558 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S265724AbUGZUjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 16:39:54 -0400
Date: Mon, 26 Jul 2004 13:29:46 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Autotune swappiness01
Message-ID: <20040726202946.GD26075@ca-server1.us.oracle.com>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <cone.1090801520.852584.20693.502@pc.kolivas.org> <20040725173652.274dcac6.akpm@osdl.org> <cone.1090802581.972906.20693.502@pc.kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cone.1090802581.972906.20693.502@pc.kolivas.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 10:43:01AM +1000, Con Kolivas wrote:
> Low memory boxes and ones that are heavily laden with applications find 
> that ends up making things slow down trying to keep all applications in 
> physical ram.

	Lowish memory boxes with plain desktop loads find that the default
of '60' is a terrible one (I'm speaking of 1GHz-ish machines with 256MB
(like mine) or 512MB (like a guy next to me)).  Every person I know who
installs 2.6 complains about how it feels slow and choppy.  I tell them
"The first thing I do after installing 2.6 is set swappiness to '20'."
Sure enough, they set swappiness to 20 and their box starts behaving
like a properly tuned one.
	I don't know what workload the default of '60' is for, but for
the (128MB < x < 1GB) of RAM case, it sucks (and I've seen the same
behavior on a 300MHz 196MB box).

Joel

-- 

"Maybe the time has drawn the faces I recall.
 But things in this life change very slowly,
 If they ever change at all."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
