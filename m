Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVILSag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVILSag (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVILSag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:30:36 -0400
Received: from xenotime.net ([66.160.160.81]:63389 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932133AbVILSaf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:30:35 -0400
Date: Mon, 12 Sep 2005 11:30:32 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: =?ISO-8859-1?Q?M=E1rcio_Oliveira?= <moliveira@latinsourcetech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Tainted lsmod output
In-Reply-To: <4325C713.6060908@latinsourcetech.com>
Message-ID: <Pine.LNX.4.50.0509121129470.30198-100000@shark.he.net>
References: <4325C713.6060908@latinsourcetech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sep 2005, Márcio Oliveira wrote:

> Hi there,
>
>    Anybody knows why lsmod command shows the fields "Tainted" and "Not
> Tainted" and what means the "P", "PF" and other letter showed in front
> of this field?
>
> Thanks a lot.

There's a patch for these in current -mm.
For now, you can read kernel/panic.c comments:

 *  'P' - Proprietary module has been loaded.
 *  'F' - Module has been forcibly loaded.
 *  'S' - SMP with CPUs not designed for SMP.
 *  'R' - User forced a module unload.
 *  'M' - Machine had a machine check experience.
 *  'B' - System has hit bad_page.

-- 
~Randy
