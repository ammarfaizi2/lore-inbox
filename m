Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWGJMTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWGJMTj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 08:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWGJMTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 08:19:39 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:32263 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S1030269AbWGJMTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 08:19:38 -0400
Date: Mon, 10 Jul 2006 14:19:28 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.17.4] slabinfo.buffer_head increases
In-Reply-To: <Pine.LNX.4.63.0607101023450.27628@pcgl.dsa-ac.de>
Message-ID: <Pine.LNX.4.63.0607101412250.27628@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0607101023450.27628@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006, Guennadi Liakhovetski wrote:

> I am obsering a steadily increasing buffer_head value in slabinfo under 
> 2.6.17.4. I searched the net / archives and didn't find anything 
> directly relevant. Does anyone have an idea or how shall we debug it?
> 
> I first noticed this "feature" on a 2.6.17-rc5 based ARM-system, where if 
> I stop some user-space applications, the number stop increasing.

Ok, after observing this for a bit longer, it looks like this:

2.6.11.10 (Debian unloaded) - stable
2.6.16.9 (Debian with desktop applications) - grew from 3000 to 6000 then 
	fell back
2.6.17-rc5 (busybox ARM with applications) - grows so far, will watch for 
	a bit longer
2.6.17.4 (SuSE, practically idle) - stable

So, I'll keep it running until tomorrow then report again, unless someone 
can tell how it is supposed to behave and whether there has been a bug and 
it has been fixed?

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
