Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbTDNJqO (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 05:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTDNJqO (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 05:46:14 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:20449 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262927AbTDNJqN (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 05:46:13 -0400
Subject: Re: 2.5.67-mm2 booting problems!
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Mads Christensen <mfc@krycek.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1050309044.2522.6.camel@krycek>
References: <1050309044.2522.6.camel@krycek>
Content-Type: text/plain
Organization: 
Message-Id: <1050314266.592.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 14 Apr 2003 11:57:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-14 at 10:30, Mads Christensen wrote:
> Ok, this puzzles me a bit - 
> i just upgraded 2.5.67 to -mm2, and it won't boot it just stalls after 
> 
> 'Booting Linux kernel....' or something similiar - and nothing. 
> 
> I have CONFIG_VT=y and CONFIG_INPUT=y set, which is why i don't get it -
> that was the problem with 2.5.67, but i fixed that, and the .config
> should be intact after patching the kernel, shouldn't it? 

I suggest you to try 2.5.67-mm3 instead. To do so, first revert
2.5.67-mm2 (patch -p1 -R), then apply 2.5.67-mm3 (patch -p1) and then
run "make oldconfig" over your current ".config" file.
-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

