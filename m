Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVFFSEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVFFSEA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 14:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVFFSD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 14:03:59 -0400
Received: from [81.2.110.250] ([81.2.110.250]:65451 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261286AbVFFSDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 14:03:55 -0400
Subject: Re: serious bug in IDE-Controller Code: Highpoint 370/2 after
	kernal 3.6.1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexander Oberhuber <lzw77rnc@gmx.at>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <6.0.3.0.2.20050605171951.041e0598@pop.chello.at>
References: <6.0.3.0.2.20050605171951.041e0598@pop.chello.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1118080897.14728.219.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 06 Jun 2005 19:01:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-06-05 at 16:32, Alexander Oberhuber wrote:
> Hi there,
> 
> I discovered a bug that prevents Linux from booting if the Highpoint 370/2 
> IDE controller is being used.

Linux doesn't support HPT372N style controllers. Someone needs to
rewrite the PLL programming code in the driver to actually work but so
far nobody has volunteere.

