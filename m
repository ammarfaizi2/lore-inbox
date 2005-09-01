Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbVIAAIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbVIAAIY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 20:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbVIAAIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 20:08:24 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:48118 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S964996AbVIAAIX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 20:08:23 -0400
Subject: RE: FW: [RFC] A more general timeout specification
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>, akpm@osdl.org,
       joe.korty@ccur.com, george@mvista.com, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0509010136350.3743@scrub.home>
References: <F989B1573A3A644BAB3920FBECA4D25A042B030A@orsmsx407>
	 <Pine.LNX.4.61.0509010136350.3743@scrub.home>
Content-Type: text/plain
Organization: MontaVista
Date: Wed, 31 Aug 2005 17:08:09 -0700
Message-Id: <1125533289.15034.64.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-01 at 01:50 +0200, Roman Zippel wrote:

> What "more versions" are you talking about? When you convert a user time 
> to kernel time you can automatically validate it and later you can use 
> standard kernel APIs, so you don't have to add even more API bloat.

What's kernel time? Are you talking about jiffies? The whole point of
multiple clocks is to allow for different degrees of precision. 

Daniel

