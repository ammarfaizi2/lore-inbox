Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbUK3SuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbUK3SuK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbUK3St5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:49:57 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:62877 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262262AbUK3Sth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:49:37 -0500
Subject: Re: Designing Another File System
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: John Richard Moser <nigelenki@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200411301828.iAUISgf8031548@turing-police.cc.vt.edu>
References: <41ABF7C5.5070609@comcast.net>
	 <200411301828.iAUISgf8031548@turing-police.cc.vt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101836768.25629.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Nov 2004 17:46:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-30 at 18:28, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 29 Nov 2004 23:32:05 EST, John Richard Moser said:
> they punt on the issue of over-writing a sector that's been re-allocated by
> the hardware (apparently the chances of critical secret data being left in
> a reallocated block but still actually readable are "low enough" not to worry).

I guess they never consider CF cards which internally are log structured
and for whom such erase operations are very close to pointless.

