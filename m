Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWB0UK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWB0UK7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWB0UK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:10:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28360 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932288AbWB0UK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:10:58 -0500
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <gregkh@suse.de>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20060227194623.GC9991@suse.de>
References: <20060227190150.GA9121@kroah.com>
	 <20060227193654.GA12788@kvack.org>  <20060227194623.GC9991@suse.de>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 21:10:50 +0100
Message-Id: <1141071050.2992.159.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Then I suggest you work with the ALSA developers to come up with such a
> "stable" api that never changes.  They have been working at this for a
> number of years, if it was a "simple" problem, it would have been done
> already...
> 
> Anyway, netlink is in the same category, with a backing userspace
> library tie :)
> 
> And, I have nothing against shipping userspace libraries with the kernel
> like this, if people think that's the easiest way to do it.  But even
> then, the raw interface is still "private" and you need to use the
> library to access it properly.

if it's this volatile, the lib should come with the kernel.


