Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbUKKAVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbUKKAVw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 19:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbUKKAVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 19:21:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:22985 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262153AbUKKAUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 19:20:32 -0500
Date: Wed, 10 Nov 2004 16:20:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix  platform_rename_gsi related ia32 build breakage
In-Reply-To: <4192A959.9020806@conectiva.com.br>
Message-ID: <Pine.LNX.4.58.0411101618320.2301@ppc970.osdl.org>
References: <4192A959.9020806@conectiva.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Nov 2004, Arnaldo Carvalho de Melo wrote:
> 
> 	This is needed to build current BK tree on IA32.

Can you please put it into some sane header file, so that if the 
definition of this thing ever changes, we'll get an error instead of a 
wrong type silently being used.

In fact, it _is_ in a hader file: <asm/acpi.h>.

Why not just include it?

		Linus
