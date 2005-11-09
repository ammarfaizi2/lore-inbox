Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965298AbVKIIRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965298AbVKIIRk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 03:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965308AbVKIIRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 03:17:40 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:39877
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965298AbVKIIRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 03:17:39 -0500
Message-Id: <4371BEEC.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 09 Nov 2005 09:18:36 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386: export genapic again
References: <4370AEE1.76F0.0078.0@novell.com> <Pine.LNX.4.58.0511081321390.15288@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0511081321390.15288@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> "Randy.Dunlap" <rdunlap@xenotime.net> 08.11.05 22:22:45 >>>
>On Tue, 8 Nov 2005, Jan Beulich wrote:
>
>> A change not too long ago made i386's genapic symbol no longer be
>> exported, and thus certain low-level functions no longer be usable.
>> Since close-to-the-hardware code may still be modular, this
>> rectifies the situation.
>>
>> From: Jan Beulich <jbeulich@novell.com>
>>
>> (actual patch attached)
>
>Having no attachments would be preferable, but if you must use
>attachments, having them marked as plain text instead of
>"octet-stream" would be a great improvement.

I'm sorry, I thought that worked now. As it turns out, they had fixed
this here in (or before) July this year, but later broke it again. The
intention is indeed to have them sent as text.

Jan
