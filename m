Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTJSTTp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 15:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTJSTTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 15:19:45 -0400
Received: from line103-242.adsl.actcom.co.il ([192.117.103.242]:7040 "EHLO
	beyondmobile1.beyondsecurity.com") by vger.kernel.org with ESMTP
	id S262120AbTJSTTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 15:19:43 -0400
From: Aviram Jenik <aviram@beyondsecurity.com>
Organization: Beyond Security Ltd.
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] Add error handling to software_suspend
Date: Sun, 19 Oct 2003 21:19:19 +0200
User-Agent: KMail/1.5.4
References: <20031018210705.GA22191@elf.ucw.cz>
In-Reply-To: <20031018210705.GA22191@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310192119.19446.aviram@beyondsecurity.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 October 2003 23:07, Pavel Machek wrote:
> Hi!
>
> This adds error handling to software_suspend(), 

Suspending to disk with this patch applied I can see the resume is stuck on:
"Waiting for DMAs to settle down..."
(previously it booted before I could see where the problem is).

I guess it's another evidence that the problem is with the i830 module?

- Aviram
