Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbVIAJ5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbVIAJ5O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 05:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbVIAJ5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 05:57:14 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:1185 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751058AbVIAJ5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 05:57:13 -0400
Subject: Re: State of Linux graphics
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Antonio Vargas <windenntw@gmail.com>
Cc: Ian Romanick <idr@us.ibm.com>, Allen Akin <akin@pobox.com>,
       Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <69304d1105083123007c00f9e0@mail.gmail.com>
References: <9e47339105083009037c24f6de@mail.gmail.com>
	 <1125422813.20488.43.camel@localhost>
	 <20050831063355.GE27940@tuolumne.arden.org>
	 <1125512970.4798.180.camel@evo.keithp.com>
	 <20050831200641.GH27940@tuolumne.arden.org>
	 <1125522414.4798.222.camel@evo.keithp.com>
	 <20050901015859.GA11367@tuolumne.arden.org> <43167150.1040808@us.ibm.com>
	 <69304d1105083123007c00f9e0@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Sep 2005 11:20:42 +0100
Message-Id: <1125570042.15768.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-01 at 08:00 +0200, Antonio Vargas wrote:
> 2. whole screen z-buffer, for depth comparison between the pixels
> generated from each window.

That one I question in part - if the rectangles are (as is typically the
case) large then the Z buffer just ups the memory accesses. I guess for
round windows it might be handy.

