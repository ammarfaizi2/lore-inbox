Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVAYNtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVAYNtT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 08:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVAYNtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 08:49:19 -0500
Received: from [81.2.110.250] ([81.2.110.250]:55707 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261937AbVAYNtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 08:49:16 -0500
Subject: Re: i8042 access timings
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <200501250241.14695.dtor_core@ameritech.net>
References: <200501250241.14695.dtor_core@ameritech.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106656268.14787.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 25 Jan 2005 12:44:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-25 at 07:41, Dmitry Torokhov wrote:
> in i8042. It made me curious as we only wait between accesses to status
> register but not data register. I peeked into FreeBSD code and they use
> delays to access both registers and I wonder if that's the piece that
> makes i8042 mysteriously fail on some boards.

Maybe - my own experience is that the last boards I've seen that
actually require the delays are the Digital Hinote laptops, so its only
stuff only
as far as I can tell


