Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266463AbUH1WPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUH1WPs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 18:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUH1WPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 18:15:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:55000 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266463AbUH1WPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 18:15:43 -0400
Subject: Re: radeonfb: do not blank during swsusp snapshot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20040828213535.GA1418@elf.ucw.cz>
References: <20040828213535.GA1418@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1093731051.2170.187.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 29 Aug 2004 08:10:52 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-29 at 07:35, Pavel Machek wrote:
> Hi!
> 
> With display blanked, it is hard to debug anything. And display
> blanking is not really needed there... Does it look okay?

Well... I have some patches for that, though not using the
system_state global (that I don't like, but it seems that you
decided to go that way anyways)....

You probably wnat to avoid the call to fb_set_suspend as well

Ben.


