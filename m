Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWEUTDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWEUTDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 15:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWEUTDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 15:03:21 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.7]:38917 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S964906AbWEUTDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 15:03:20 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: Linux Kernel Source Compression
Date: Sun, 21 May 2006 20:03:32 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, apiszcz@lucidpixels.com
References: <Pine.LNX.4.64.0605211028100.4037@p34>
In-Reply-To: <Pine.LNX.4.64.0605211028100.4037@p34>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605212003.32063.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 May 2006 15:35, Justin Piszcz wrote:
> Was curious as to which utilities would offer the best compression ratio
> for the kernel source, I thought it'd be bzip2 or rar but lzma wins,
> roughly 6 MiB smaller than bzip2.
>
> $ du -sk * | sort -n
> 33520   linux-2.6.16.17.tar.lzma

Somebody needs to make lzma userspace tools (like p7zip) faster, not crash, 
and behave like a regular UNIX program. Then we need a patch to GNU tar to 
emerge, and for it to persist for at least 4 years. Then maybe people will 
adopt this format..

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
