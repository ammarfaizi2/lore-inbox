Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUAIOWP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 09:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbUAIOWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 09:22:15 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56514 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261731AbUAIOWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 09:22:14 -0500
Date: Fri, 9 Jan 2004 15:21:58 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.1-mm1
In-Reply-To: <Pine.LNX.4.58L.0401091550150.6458@alpha.zarz.agh.edu.pl>
Message-ID: <Pine.GSO.4.58.0401091515190.5021@mion.elka.pw.edu.pl>
References: <20040109014003.3d925e54.akpm@osdl.org>
 <Pine.LNX.4.58L.0401091550150.6458@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Jan 2004, Wojciech 'Sas' Cieciwa wrote:

> On Fri, 9 Jan 2004, Andrew Morton wrote:
>
> [...]
> >
> > - The PCI IDE drivers should work as modules now.

They always have worked as modules, it fixes case when PCI driver tried
to overtake interfaces already controlled by generic IDE code.

> shouldn't ..
> returned warnings like I've posted

You are talking about IDE as module not PCI IDE modules.

--bart
