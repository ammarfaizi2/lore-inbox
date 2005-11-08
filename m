Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965204AbVKHORG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965204AbVKHORG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 09:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbVKHORG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 09:17:06 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:9541
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965204AbVKHORE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 09:17:04 -0500
Message-Id: <4370C1A7.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 15:17:59 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386: export genapic again
References: <4370AEE1.76F0.0078.0@novell.com> <20051108132954.GQ3847@stusta.de>
In-Reply-To: <20051108132954.GQ3847@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Adrian Bunk <bunk@stusta.de> 08.11.05 14:29:54 >>>
>On Tue, Nov 08, 2005 at 01:57:53PM +0100, Jan Beulich wrote:
>> A change not too long ago made i386's genapic symbol no longer be
>> exported, and thus certain low-level functions no longer be usable.
>> Since close-to-the-hardware code may still be modular, this
>> rectifies the situation.
>
>We don't export symbols for "there might be some driver that might
need 
>this".
>
>Can we discuss this issue when such a driver gets submitted for 
>inclusion in the kernel?

I'm in the process of preparing such a submission.

Jan
