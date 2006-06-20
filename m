Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWFTWXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWFTWXq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWFTWXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:23:46 -0400
Received: from xenotime.net ([66.160.160.81]:49078 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751297AbWFTWXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:23:45 -0400
Date: Tue, 20 Jun 2006 15:26:31 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: hostmaster@ed-soft.at, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines
Message-Id: <20060620152631.287b8262.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0606202357330.17281@yvahk01.tjqt.qr>
References: <4497F85B.7010409@ed-soft.at>
	<20060620101605.0240a685.rdunlap@xenotime.net>
	<Pine.LNX.4.61.0606202357330.17281@yvahk01.tjqt.qr>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 23:58:57 +0200 (MEST) Jan Engelhardt wrote:

> >
> >Darn, I was going to comment on the patch, but the attachment
> >isn't quoted... :(
> >
> >
> >1.  if you modify this patch, change
> >+	if(!efi_enabled) {
> >to
> >	if (!efi_enabled) {
> >to be compatible with Linux coding style.
> >
> Care to name the section this is listed in? It is used all over the place 
> in examples in the CodingStyle document, but I could not find an 
> explanation which explicitly says "space after if".

Nope, I didn't say compatible with Documentation/CodingStyle.
I'm just basing it on visible evidence in source files and
many emails requesting the same.

---
~Randy
