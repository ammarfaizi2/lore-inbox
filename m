Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbUKOCZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbUKOCZJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 21:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbUKOCYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:24:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27835 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261427AbUKOCUg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:20:36 -0500
Message-ID: <41981266.2070707@pobox.com>
Date: Sun, 14 Nov 2004 21:20:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: x86: only single-step into signal handlers if the tracer
References: <200411150203.iAF23Trb024677@hera.kernel.org>
In-Reply-To: <200411150203.iAF23Trb024677@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.2159, 2004/11/15 00:56:31-08:00, torvalds@ppc970.osdl.org
> 
> 	x86: only single-step into signal handlers if the tracer
> 	asked for it.


This reminds me of a problem I am seeing under recent -bk kernels.

Mozilla (FC2) will freeze (no screen redraws, etc.).  'ps xf' shows 
mozilla sleeping.  If I strace the process, Mozilla will un-freeze and 
continue as expected.

	Jeff


