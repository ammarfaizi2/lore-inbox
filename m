Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbUAJP4q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 10:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265242AbUAJP4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 10:56:45 -0500
Received: from h192n2fls310o1003.telia.com ([81.224.187.192]:56469 "EHLO
	cambrant.com") by vger.kernel.org with ESMTP id S265238AbUAJP4o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 10:56:44 -0500
Date: Sat, 10 Jan 2004 16:56:26 +0100
From: Tim Cambrant <tim@cambrant.com>
To: Mario Vanoni <vanonim@bluewin.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-mm2: compiler warning
Message-ID: <20040110155626.GA20684@cambrant.com>
References: <40001CEE.5050206@bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <40001CEE.5050206@bluewin.ch>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 04:40:30PM +0100, Mario Vanoni wrote:
> Compiling the kernel under 2.6.1-mm2, gcc-3.3.2
> (same messages as under 2.6.1-rc1-mm1, re-tested),
> 
> arch/i386/boot/setup.S: Assembler messages:
> arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to 
> 0x37ffffff
> 

This is apparently a known problem and has existed for a long time,
but no-one has fixed it for some reason. I asked the exacly same
question a few months ago, and someone told me that this issue has
been around forever, but is noticed under 2.6, since it is less
verbose during the compilation. I'll pass the message that was told
to me: If you've got a fix, it would surely be included in the kernel.

                Tim Cambrant
