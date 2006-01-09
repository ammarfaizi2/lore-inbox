Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWAIQFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWAIQFD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWAIQFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:05:03 -0500
Received: from [81.2.110.250] ([81.2.110.250]:61660 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932408AbWAIQFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:05:00 -0500
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux
	can't for a long time
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Yaroslav Rastrigin <yarick@it-territory.ru>
Cc: Kasper Sandberg <lkml@metanurb.dk>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200601091656.48355.yarick@it-territory.ru>
References: <174467f50601082354y7ca871c7k@mail.gmail.com>
	 <200601091403.46304.yarick@it-territory.ru>
	 <1136813783.8412.4.camel@localhost>
	 <200601091656.48355.yarick@it-territory.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Jan 2006 16:07:07 +0000
Message-Id: <1136822827.6659.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-01-09 at 16:56 +0300, Yaroslav Rastrigin wrote:
> No. Fully loaded KDE session (without kdesktop and kwin, since I don't
> use first and using my own WM instead of second).
> So almost all necessary libraries are hot and loaded, and all what's
> missing is a dozen of Window's and Pixmap's to allocate and two
> threads to 
> handle events. And it takes seconds, not tens of a second, as in
> UltraEdit case 


Currently Linux performance loading large binaries is at least
perceptually worse than Windows (some of that is perceptual tricks
windows apps pull, some of it real). There is an openoffice.org related
analysis project currently under way to sort that out.

A second problem is the popularity of some very inefficiently written
desktops which badly need a good optimise, a diet and/or stuffing where
the sun doesn't shine. The kernel can only do so much of the work and
comparing xfce4 with gnome/kde shows that the kernel isn't the only
party involved in this....

Alan

