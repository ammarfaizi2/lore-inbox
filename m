Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268005AbUJDLZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268005AbUJDLZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 07:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbUJDLZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 07:25:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:31874 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268005AbUJDLZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 07:25:26 -0400
Subject: Re: [PATCH] -mm swsusp: copy_page is harmfull
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041004093330.GA7614@elf.ucw.cz>
References: <200409292014.i8TKEhov023334@hera.kernel.org>
	 <1096847414.23142.42.camel@gaston>  <20041004093330.GA7614@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1096888829.9539.75.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 04 Oct 2004 21:20:29 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-04 at 19:33, Pavel Machek wrote:

> Hmm but does it matter? Is that operation really that slow on ppc?
> This whole copy takes maybe second on x86, other operations are way
> slower...

No, you are right, it probably doesn't matter.

Ben.


