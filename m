Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265328AbUATJag (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 04:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265329AbUATJag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 04:30:36 -0500
Received: from denise.shiny.it ([194.20.232.1]:32679 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S265328AbUATJae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 04:30:34 -0500
Date: Tue, 20 Jan 2004 10:30:25 +0100 (CET)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: David Schwartz <davids@webmaster.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: License question
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMEJCJKAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.58.0401201015250.30196@denise.shiny.it>
References: <MDEHLPKNGKAHNMBLJOLKMEJCJKAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Jan 2004, David Schwartz wrote:
>
> > Since their code is C++ I already rewote everything in C, but it
> > also contains the binary firmwares which I can't rewrite. That's
> > why I asked you about the license.
>
> 	Then you have another problem. You can't place something under the GPL if
> you don't have the source code to it.

This issue was raised on the list a few months ago. Someone's opinion was
that the firmware is not executed by the same processor that runs Linux,
thus it's data, not code. Uploading a firmware is like printing an image
on the screen. Anyway I can upload the firmware from userspace. On most
(but not all) cards I only need the firmware at startup, so I also save
memory. Some cards also have an ASIC which must be loaded. That data is
not code because it's not executed.


--
Giuliano.
