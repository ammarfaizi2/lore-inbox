Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbTAJKwZ>; Fri, 10 Jan 2003 05:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbTAJKwZ>; Fri, 10 Jan 2003 05:52:25 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:25489
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264863AbTAJKwY>; Fri, 10 Jan 2003 05:52:24 -0500
Subject: Re: Are linux network drivers really affected by this?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andrea.glorioso@binary-only.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87iswx4eaw.fsf@topo.binary-only.priv>
References: <1042116723.2556.3.camel@station3>
	 <87iswx4eaw.fsf@topo.binary-only.priv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042199207.28469.49.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 11:46:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 08:08, andrea.glorioso@binary-only.com wrote:
> The paper presented by Olaf Arkin (amongst other) points to some parts
> of the linux code where this "vulnerability" exists.  I think Alan Cox
> is working on some patches for his tree.  I wonder whether it's better
> to null-pad  ethernet packets  or   to fill  them with  random  values
> (possibly an overkill, but more resiliant against fingerprinting).

Most of them will pad with zero. We have a couple of drivers that already
pad with something along the lines of "NetBSD is a cool OS too.."

The -ac tree should have the problem fixed for all the drivers I know have
the problem or may do.

