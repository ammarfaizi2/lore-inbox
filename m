Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWFWN5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWFWN5z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWFWN5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:57:49 -0400
Received: from ns1.suse.de ([195.135.220.2]:940 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750729AbWFWNqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:46:35 -0400
From: Andi Kleen <ak@suse.de>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] x86_64: another fix for canonical RIPs during signal handling
Date: Fri, 23 Jun 2006 15:46:21 +0200
User-Agent: KMail/1.9.3
Cc: pageexec@freemail.hu, marcelo@kvack.org, linux-kernel@vger.kernel.org
References: <449BC808.4174.277D15CF@pageexec.freemail.hu> <449C0616.4382.286F7C8C@pageexec.freemail.hu> <20060623133217.GA24737@1wt.eu>
In-Reply-To: <20060623133217.GA24737@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606231546.21731.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If I understand it well, an application which maps address 0 has no way to
> be notified that the kernel detected a corrupted stack pointer. 

It will just not crash again after the application tried to deliberately
crash the kernel.

> I agree 
> that if the proposed patch avoids to make this undesired distinction between
> apps that map addr 0 and those which don't, it would be better to merge it.
> Andi, you said there was nothing wrong with it, do you accept that it gets
> merged ?

As I said, it's not wrong, just not necessary.

-Andi
