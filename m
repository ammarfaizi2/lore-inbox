Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWAFNob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWAFNob (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 08:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWAFNob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 08:44:31 -0500
Received: from [81.2.110.250] ([81.2.110.250]:40658 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932410AbWAFNob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 08:44:31 -0500
Subject: Re: 2.6.15-mm1 - locks solid when starting KDE (EDAC errors)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490601051552x4c8315e7n3c61860283a95716@mail.gmail.com>
References: <9a8748490601051552x4c8315e7n3c61860283a95716@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Jan 2006 13:46:46 +0000
Message-Id: <1136555206.30498.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-01-06 at 00:52 +0100, Jesper Juhl wrote:
> Unfortunately not much makes it to the logs. The only things I can
> find is this :
> 
> Jan  6 00:18:39 dragon kernel: [   19.479000] Write protecting the
> kernel read-only data: 333k
> Jan  6 00:18:57 dragon kernel: [   46.416000] EDAC PCI- Signaled
> System Error on 0000:00:18.2
> Jan  6 00:18:57 dragon kernel: [   46.416000] EDAC PCI- Master Data
> Parity Error on 0000:00:18.2
> Jan  6 00:18:57 dragon kernel: [   46.416000] EDAC PCI- Detected
> Parity Error on 0000:00:18.2
> <<<here I power off the system since it's locked solid>>>

If those occur just at boot then they may be noise from the bios setup.
Can you build without EDAC and check if that stops the crash. It
shouldn't stop it crashing but if it does then its important to know

