Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281429AbRKPO1A>; Fri, 16 Nov 2001 09:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281430AbRKPO0s>; Fri, 16 Nov 2001 09:26:48 -0500
Received: from t2.redhat.com ([199.183.24.243]:60404 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S281429AbRKPO0h>; Fri, 16 Nov 2001 09:26:37 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3BF4F6A6.10163203@evision-ventures.com> 
In-Reply-To: <3BF4F6A6.10163203@evision-ventures.com>  <20011115233528.A7496@elf.ucw.cz> 
To: dalecki@evision.ag
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: __get_free_pages but no get_free_pages? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 16 Nov 2001 14:25:58 +0000
Message-ID: <5431.1005920758@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


dalecki@evision-ventures.com said:
>  That's purposedly so to discourage the usage of it, since this
> function should be considered as an "implementation detail" I think.

An implementation detail that should be hidden from generic code.
Like the fact that we use slabs for malloc?

--
dwmw2


