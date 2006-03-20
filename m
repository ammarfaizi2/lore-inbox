Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbWCTVjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWCTVjv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWCTVjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:39:51 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:59548 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964982AbWCTVju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:39:50 -0500
Date: Mon, 20 Mar 2006 22:39:45 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nathan Scott <nathans@sgi.com>
cc: linux-xfs@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Parenthesize macros in xfs
In-Reply-To: <20060321082327.B653275@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.61.0603202239110.11933@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0603202207310.20060@yvahk01.tjqt.qr>
 <20060321082327.B653275@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hello xfs list,
>
>Hi Jan,
>
>> while browsing through the xfs/linux source, I noticed that many macros do 
>> not do proper bracing. I have started to cook up a patch, but would like 
>> feedback first before I continue for nothing.
>> It goes like this:
>> ...
>
>That looks fine.  Please be sure to work on the -mm tree or on
>CVS on oss.sgi.com, so as to reduce your level of patch conflict.
>

Hm, would not it even be better to make them 'static inline' functions?


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
