Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVDESp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVDESp4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVDESpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:45:16 -0400
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:19974 "EHLO
	smtp-vbr14.xs4all.nl") by vger.kernel.org with ESMTP
	id S261913AbVDESmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:42:37 -0400
In-Reply-To: <20050405164815.GI17299@kroah.com>
References: <20050405164539.GA17299@kroah.com> <20050405164815.GI17299@kroah.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c8cb775b8f5507cbac1fb17b1028cffc@xs4all.nl>
Content-Transfer-Encoding: 7bit
Cc: stable@kernel.org, jdike@karaya.com, linux-kernel@vger.kernel.org,
       blaisorblade@yahoo.it
From: Renate Meijer <kleuske@xs4all.nl>
Subject: Re: [08/08] uml: va_copy fix
Date: Tue, 5 Apr 2005 20:47:59 +0200
To: Greg KH <gregkh@suse.de>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 5, 2005, at 6:48 PM, Greg KH wrote:

> -stable review patch.  If anyone has any objections, please let us 
> know.
>
> ------------------
>
> Uses __va_copy instead of va_copy since some old versions of gcc 
> (2.95.4
> for instance) don't accept va_copy.

Are there many kernels still being built with 2.95.4? It's quite 
antiquated, as far as
i'm aware.

The use of '__' violates compiler namespace. If 2.95.4 were not easily 
replaced by
a much better version (3.3.x? 3.4.x) I would see a reason to disregard 
this, but a fix
merely to satisfy an obsolete compiler?

In my humblest of opinions you are fixing a bug that is better solved 
by  downloading
a more recent version of gcc.


Regards,

Renate Meijer.

