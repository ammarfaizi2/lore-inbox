Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbSKMNvC>; Wed, 13 Nov 2002 08:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261450AbSKMNvB>; Wed, 13 Nov 2002 08:51:01 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:36009 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261449AbSKMNvA> convert rfc822-to-8bit; Wed, 13 Nov 2002 08:51:00 -0500
Subject: Re: repeatable IDE errors when using SMART
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1037180301.8013.5.camel@localhost>
References: <Pine.LNX.4.44.0211121800320.20949-100000@twinlark.arctic.org> 
	<1037180301.8013.5.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Nov 2002 14:23:15 +0000
Message-Id: <1037197395.11996.59.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-13 at 09:38, Xavier Bestel wrote:
> Le mer 13/11/2002 Ã  03:19, dean gaudet a écrit:
> > i'm 99.99% certain that the use of smartctl and/or hddtemp is causing my
> > system to lose contact with the drives.  there's just been far too many
> > concidental errors of this sort:
> 
> Maybe I've seen something like this too, but I'm not sure.

Its certainly part of the code thats quite convoluted and would be the
ideal spot for a race. Really for the new IDE it wants testing versus
2.5.47-ac but getting 2.5.47 (ac or otherwise) to stay up for 8 hours is
challenging

