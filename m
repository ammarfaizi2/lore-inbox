Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268323AbUJPGTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268323AbUJPGTE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 02:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268315AbUJPGTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 02:19:04 -0400
Received: from gate.perex.cz ([82.113.61.162]:33957 "EHLO mail.perex.cz")
	by vger.kernel.org with ESMTP id S268662AbUJPGS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 02:18:58 -0400
Date: Sat, 16 Oct 2004 08:23:08 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Bill Nottingham <notting@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALSA registering controlC0 with no actual card available
In-Reply-To: <20041015222011.GB6110@nostromo.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0410160820020.1701@pnote.perex-int.cz>
References: <20041015222011.GB6110@nostromo.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004, Bill Nottingham wrote:

> ALSA registers controlC0 for the first card when there is
> no card actually available - why?

It's used for generating an automatic request to load ALSA modules using
request_module("snd-card-#").

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
