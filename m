Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTHZTho (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 15:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbTHZThn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 15:37:43 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:63198 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262789AbTHZThh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 15:37:37 -0400
Date: Tue, 26 Aug 2003 16:33:09 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.23-pre1] /proc/ikconfig support
Message-ID: <Pine.LNX.4.55L.0308261629400.18109@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 26 Aug 2003 18:36:59 +0200 Marc-Christian Petersen
<m.c.p@wolk-project.de> wrote:

| On Monday 25 August 2003 19:50, Marc-Christian Petersen wrote:
|
| Hi Marcelo,
|
| > Idea/Patch from Randy Dunlap including fixes/updates:
| > From: Daniele Bellucci <bellucda@tiscali.it>
| >     put_user() to return -EFAULT on error.
| > From: Randy.Dunlap" <rddunlap@osdl.org>
| >     Updated 'extract-ikconfig' script
| > From me:
| >     /proc/ikconfig should only be allowed if CONFIG_PROC_FS=y
| > Attached is /proc/ikconfig support.
...
|
| something not ok with this or do you just need some time to review it?
:)

> I have the same question about the seq_file "single" additions
> patch that I sent yesterday.... ???

The seq_file patch needs EXPORT_SYMBOL right?

And about ikconfig, hum, I'm not sure if I want that. Its nice, yes, but I
still wonder. You are free to convince me though: I think people usually
know what they compile in their kernels, dont they?


