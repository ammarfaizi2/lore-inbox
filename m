Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946023AbWGOK4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946023AbWGOK4u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 06:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946022AbWGOK4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 06:56:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57987 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946020AbWGOK4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 06:56:49 -0400
Subject: Re: tighten ATA kconfig dependancies
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, Dave Jones <davej@redhat.com>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060715102825.GR3633@stusta.de>
References: <20060715053418.GA5557@redhat.com>
	 <1152942548.3114.4.camel@laptopd505.fenrus.org>
	 <20060715063827.GA24579@mars.ravnborg.org>
	 <1152945956.3114.6.camel@laptopd505.fenrus.org>
	 <20060715102825.GR3633@stusta.de>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 12:56:43 +0200
Message-Id: <1152961003.3114.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > the point is that it doesn't fall out naturally, and thus things get
> > needlessly missed.
> 
> It seems the main question is:
> Is the kernel configuration mainly designed for users or for developers?
> 
> For users, showing drivers for hardware that is not present on their 
> platform only causes confusion.

well Aunt Tilly gets confused by all hardware that is not present on her
machine; she has no idea what a platform is. By that reasoning, we
should make kconfig hide all non-present hardware.

Also I think there is no difference in confusion between showing 10 or
15 IDE chipsets. Either the user knows what he has (and then it doesn't
matter) or those 10 are too much already.


