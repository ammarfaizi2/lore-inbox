Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161076AbWJPWpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbWJPWpg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 18:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161142AbWJPWpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 18:45:36 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58769 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161076AbWJPWpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 18:45:36 -0400
Subject: Re: VCD not readable under 2.6.18
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: wixor <wixorpeek@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <c43b2e150610161153x28fef90bw4922f808714b93fd@mail.gmail.com>
References: <c43b2e150610161153x28fef90bw4922f808714b93fd@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Oct 2006 00:12:25 +0100
Message-Id: <1161040345.24237.135.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-16 am 20:53 +0200, ysgrifennodd wixor:
> (kernel is not tained though) - i've tried dd if=/dev/hda of=/dev/null
> - that's how i now the first 8 megs work fine. It includes the startup
> messages too. You can see I have reloaded cdrom driver with debug=1
> there, hoping it will expose some usefull info - it seems it didn't
> however.

Multimedia sectors on a VCD are not readable by dd or the filesystem
layer, you must use a specific vcd player app so the dd test fail is
expected. The xine one is more interesting. Is Xine being fooled by the
fact its a multisession disk of some form perhaps >?

