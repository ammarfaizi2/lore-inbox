Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131899AbREBLLf>; Wed, 2 May 2001 07:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132606AbREBLLZ>; Wed, 2 May 2001 07:11:25 -0400
Received: from smtp.mountain.net ([198.77.1.35]:10761 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S131899AbREBLLM>;
	Wed, 2 May 2001 07:11:12 -0400
Message-ID: <3AEFEB0E.1C464EA9@mountain.net>
Date: Wed, 02 May 2001 07:10:06 -0400
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.3 i486)
X-Accept-Language: English/United, States, en-US, English/United, Kingdom, en-GB, English, en, French, fr, Spanish, es, Italian, it, German, de, , ru
MIME-Version: 1.0
To: Seth Goldberg <bergsoft@home.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Followup to previous post: Atlon/VIA Instabilities
In-Reply-To: <3AEE9EA0.3752F0C0@home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seth Goldberg wrote:
> 
> Hi,
> 
>   So it seems that CONFIG_X86_USE_3DNOW is simply used to
> enable access to the routines in mmx.c (the athlon-optimized
> routines on CONFIG_K7 kernels), so then it appears that somehow
> this is corrupting memory / not behaving as it should (very
> technical, right?) :)...
> 
>  --Seth

This is a shot in the dark. Do you have floating-point emulation on
(CONFIG_MATH_EMULATION=y)?

Tom

-- 
The Daemons lurk and are dumb. -- Emerson
