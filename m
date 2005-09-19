Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbVISKXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbVISKXA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 06:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbVISKXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 06:23:00 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:11908 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932257AbVISKW7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 06:22:59 -0400
Subject: Re: [Patch] Support UTF-8 scripts
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: "Martin v." =?ISO-8859-1?Q?L=F6wis?= <martin@v.loewis.de>,
       Martin Mares <mj@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20050919072446.GF1893@elf.ucw.cz>
References: <4NsP1-3YF-21@gated-at.bofh.it> <4NsOZ-3YF-9@gated-at.bofh.it>
	 <4NsYH-4bv-27@gated-at.bofh.it> <4NtBr-4WU-3@gated-at.bofh.it>
	 <4NtL0-5lQ-13@gated-at.bofh.it> <432B2C49.8080008@v.loewis.de>
	 <20050917120123.GA3095@ucw.cz> <432C0B51.704@v.loewis.de>
	 <20050919070820.GA2382@elf.ucw.cz> <432E6649.1070408@v.loewis.de>
	 <20050919072446.GF1893@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Sep 2005 11:48:51 +0100
Message-Id: <1127126931.22124.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-09-19 at 09:24 +0200, Pavel Machek wrote:
> > which reinterprets the first line, and then invokes the eventual
> > interpreter.
> 
> Who cares? exec is fast.

It would be nice if it was but exec + user space overhead of startup is
merely "faster than many equivalent systems". It's still slow


