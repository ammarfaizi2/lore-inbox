Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVGVXbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVGVXbp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 19:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVGVXbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 19:31:44 -0400
Received: from twin.jikos.cz ([213.151.79.26]:9375 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S262226AbVGVXaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 19:30:22 -0400
Date: Sat, 23 Jul 2005 01:30:17 +0200 (CEST)
From: Jirka Kosina <jikos@jikos.cz>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: vamsi krishna <vamsi.krishnak@gmail.com>,
       Bhanu Kalyan Chetlapalli <chbhanukalyan@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Whats in this vaddr segment 0xffffe000-0xfffff000 ---p ?
In-Reply-To: <Pine.LNX.4.61.0507221515040.18320@chaos.analogic.com>
Message-ID: <Pine.LNX.4.58.0507230128490.8813@twin.jikos.cz>
References: <3faf0568050721232547aa2482@mail.gmail.com>
 <7d15175e050722072727a7f539@mail.gmail.com> <3faf0568050722081890a2e@mail.gmail.com>
 <Pine.LNX.4.61.0507221154150.16740@chaos.analogic.com>
 <3faf056805072210563ed8f158@mail.gmail.com> <Pine.LNX.4.61.0507221515040.18320@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2005, linux-os (Dick Johnson) wrote:

> Seems to be readable and starts with 'ELF'. It's something the the 'C'
> runtime may library use to make syscalls to the kernel. Older libraries
> used interrupt 0x80, newer ones may use this. Roland McGrath has made
> patches to this segment so maybe he knows.

This page is a vsyscall page. See http://lwn.net/Articles/30258/

-- 
JiKos.
