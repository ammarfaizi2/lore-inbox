Return-Path: <linux-kernel-owner+w=401wt.eu-S932711AbWLNNK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711AbWLNNK4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 08:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932712AbWLNNK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 08:10:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57260 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932711AbWLNNKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 08:10:55 -0500
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
	for 2.6.19]
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Alan <alan@lxorguk.ukuu.org.uk>,
       =?ISO-8859-1?Q?Hans-J=FCrgen?= Koch <hjk@linutronix.de>,
       Hua Zhong <hzhong@gmail.com>, "'Martin J. Bligh'" <mbligh@mbligh.org>,
       "'Linus Torvalds'" <torvalds@osdl.org>, "'Greg KH'" <gregkh@suse.de>,
       "'Jonathan Corbet'" <corbet@lwn.net>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Michael K. Edwards'" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0612141354410.6223@yvahk01.tjqt.qr>
References: <4580E37F.8000305@mbligh.org>
	 <003801c71f45$45d722c0$6721100a@nuitysystems.com>
	 <20061214111439.11bed930@localhost.localdomain>
	 <200612141231.17331.hjk@linutronix.de>
	 <20061214124241.44347df6@localhost.localdomain>
	 <Pine.LNX.4.61.0612141354410.6223@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=UTF-8
Organization: Intel International BV
Date: Thu, 14 Dec 2006 14:10:30 +0100
Message-Id: <1166101830.27217.1037.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 13:55 +0100, Jan Engelhardt wrote:
> On Dec 14 2006 12:42, Alan wrote:
> >On Thu, 14 Dec 2006 12:31:16 +0100
> >Hans-Jürgen Koch <hjk@linutronix.de> wrote:
> >> You think it's easier for a manufacturer of industrial IO cards to
> >> debug a (large) kernel module?
> >
> >You think its any easier to debug because the code now runs in ring 3 but
> >accessing I/O space.
> 
> A NULL fault won't oops the system,

.. except when the userspace driver crashes as a result and then the hw
still crashes the hw (for example via an irq storm or by tying the PCI
bus or .. )


