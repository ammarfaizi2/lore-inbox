Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbUKKAZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbUKKAZl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 19:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbUKKAZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 19:25:40 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:33801 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262069AbUKKAXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 19:23:32 -0500
Message-ID: <4192B11A.3070002@conectiva.com.br>
Date: Wed, 10 Nov 2004 22:23:54 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Organization: Conectiva S.A.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix  platform_rename_gsi related ia32 build breakage
References: <4192A959.9020806@conectiva.com.br> <Pine.LNX.4.58.0411101618320.2301@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411101618320.2301@ppc970.osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 10 Nov 2004, Arnaldo Carvalho de Melo wrote:
> 
>>	This is needed to build current BK tree on IA32.
> 
> 
> Can you please put it into some sane header file, so that if the 
> definition of this thing ever changes, we'll get an error instead of a 
> wrong type silently being used.
> 
> In fact, it _is_ in a hader file: <asm/acpi.h>.
> 
> Why not just include it?

Look at the other messages in this brown paper bag saga... It is already
in asm/acpi.h, but depends on some config options, etc.

- Arnaldo
