Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbVLPW3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbVLPW3T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 17:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbVLPW3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 17:29:18 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:63389 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932546AbVLPW3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 17:29:18 -0500
Date: Fri, 16 Dec 2005 23:28:59 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: agpgart.ko can't be unloaded
In-Reply-To: <m3acf2i05d.fsf@defiant.localdomain>
Message-ID: <Pine.LNX.4.61.0512162327010.24996@yvahk01.tjqt.qr>
References: <m3acf2i05d.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>I recently noticed that agpgart.ko (and corresponding hardware driver)
>can't be unloaded:
>
>Module                  Size  Used by
>intel_agp              19228  1 
>agpgart                27592  1 intel_agp
>
>The same is true for via_agp and probably for all other drivers.

I am able to remove it with "rmmod -f" without problems and reinsert
them again. It does not feel good, but at least they are out when
one really wants to.


Jan Engelhardt
-- 
