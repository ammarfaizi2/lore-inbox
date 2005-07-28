Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVG1X2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVG1X2o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 19:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVG1X2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 19:28:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62663 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261965AbVG1X2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 19:28:43 -0400
Date: Thu, 28 Jul 2005 16:27:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: pavel@ucw.cz, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Task notifier: Implement todo list in task_struct
Message-Id: <20050728162738.5f270b4c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0507281559400.15569@graphe.net>
References: <200507260340.j6Q3eoGh029135@shell0.pdx.osdl.net>
	<Pine.LNX.4.62.0507272018060.11863@graphe.net>
	<20050728074116.GF6529@elf.ucw.cz>
	<Pine.LNX.4.62.0507280804310.23907@graphe.net>
	<20050728193433.GA1856@elf.ucw.cz>
	<Pine.LNX.4.62.0507281251040.12675@graphe.net>
	<Pine.LNX.4.62.0507281254380.12781@graphe.net>
	<20050728212715.GA2783@elf.ucw.cz>
	<20050728213254.GA1844@elf.ucw.cz>
	<Pine.LNX.4.62.0507281456240.14677@graphe.net>
	<20050728221228.GB1872@elf.ucw.cz>
	<Pine.LNX.4.62.0507281559400.15569@graphe.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@lameter.com> wrote:
>
> On Fri, 29 Jul 2005, Pavel Machek wrote:
> 
> > > Dont fix it up. Remove the ealier patch.
> > 
> > Oops. Do you happen to have patch relative to -mm or something? I'd
> > prefer not to mess it up second time...
> 
> Ok. I will make a patch against mm tomorrow.

Well if you want to go this way I can just drop the TIF_FREEZE stuff and
use the patches-relative-to-mainline.
