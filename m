Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279307AbRKIF0i>; Fri, 9 Nov 2001 00:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279317AbRKIF02>; Fri, 9 Nov 2001 00:26:28 -0500
Received: from illiter.at ([63.113.167.61]:51593 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S279313AbRKIF0U>;
	Fri, 9 Nov 2001 00:26:20 -0500
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add function attributes to sprintf() and snprintf()
In-Reply-To: <20011107172401.I14594@arthur.ubicom.tudelft.nl>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 09 Nov 2001 00:24:34 -0500
In-Reply-To: <20011107172401.I14594@arthur.ubicom.tudelft.nl>
Message-ID: <nnadxwectp.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw <J.A.K.Mouw@its.tudelft.nl> writes:

> Hi,
> 
> This patch adds function attributes to sprintf() and snprintf() so the
> compiler can catch formatting errors at compile time. Patch is against
> 2.4.13-ac8, but it should apply cleanly against 2.4.14 as well.

 This is done inside gcc as sprintf/snprintf/vsnprintf etc. are all
standard symbols so gcc automatically adds the attributes for them.

 In gcc 3.x it's all done in gcc/builtin-attrs.def

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
