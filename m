Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292574AbSCJEXw>; Sat, 9 Mar 2002 23:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292715AbSCJEXn>; Sat, 9 Mar 2002 23:23:43 -0500
Received: from zero.tech9.net ([209.61.188.187]:34567 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292574AbSCJEXe>;
	Sat, 9 Mar 2002 23:23:34 -0500
Subject: RE: Kernel 2.5.6 Interactive performance
From: Robert Love <rml@tech9.net>
To: charles-heselton@cox.net
Cc: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Dan Mann <mainlylinux@attbi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        "J.A. Magallon" <jamagallon@able.es>
In-Reply-To: <NFBBKFIFGLNJKLMMGGFPKEPDCFAA.charles-heselton@cox.net>
In-Reply-To: <NFBBKFIFGLNJKLMMGGFPKEPDCFAA.charles-heselton@cox.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 09 Mar 2002 23:23:48 -0500
Message-Id: <1015734229.858.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-03-09 at 20:15, Charles Heselton wrote:

> That would be great.  I'm currently running 2.4.18.  I'm always up for
> things that would help improve performance, even if they are "experimental".

A good base is Alan's tree, available at:

	http://www.kernel.org/pub/linux/kernel/people/alan/linux-2.4/2.4.19/patch-2.4.19-pre2-ac4.gz

which is to be applied on top of 2.4.19-pre2.  It contains the O(1)
scheduler and rmap VM.  If you are interested in preemption, the
preempt-kernel patch is available at:

	http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/

The 2.5 tree also has most of these toys, and is a better place for this
development IMO.  Personally, I'd stay away from these all-in-one silly
patches that are floating around these days.  Your safest bet is just
stock 2.4.18 or whatever is latest, although the above addons are all at
varying levels of "stable" and "safe".

	Robert Love

