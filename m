Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbUC1CJf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 21:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUC1CJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 21:09:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:60314 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261987AbUC1CJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 21:09:34 -0500
Date: Sat, 27 Mar 2004 18:09:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Glenn Johnson <glennpj@charter.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm[34] causes drop in DRI FPS
Message-Id: <20040327180932.10e4bae7.akpm@osdl.org>
In-Reply-To: <1080435375.8280.1.camel@gforce.johnson.home>
References: <1080435375.8280.1.camel@gforce.johnson.home>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Glenn Johnson <glennpj@charter.net> wrote:
>
> The last two iterations of -mm kernels have caused my FPS count via
> glxgears to drop from about 2000 fps to about 180 fps. I rebuilt X11 to
> see if that would help but it did not.
> 
> This is with a Radeon 9100 AGP card and an Intel 865PE based
> motherboard.

It could be the AGP changes.  Please do a `patch -p1 -R' of
bk-agpgart.patch and retest?

