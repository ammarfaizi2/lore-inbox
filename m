Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263218AbREMSIU>; Sun, 13 May 2001 14:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263219AbREMSIL>; Sun, 13 May 2001 14:08:11 -0400
Received: from t2.redhat.com ([199.183.24.243]:35834 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263218AbREMSIC>; Sun, 13 May 2001 14:08:02 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <01051221352600.01254@lonewolf.Stanford.EDU> 
In-Reply-To: <01051221352600.01254@lonewolf.Stanford.EDU> 
To: akalin@Stanford.EDU
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Patches for unchecked pointers in various drivers 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 13 May 2001 19:07:38 +0100
Message-ID: <24376.989777258@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


akalin@Stanford.EDU said:
> We've identified several unchecked pointers using the Stanford checker
> and have produced patches for them:

> FTL (a memory card driver)

Patch applied to the master CVS, along with a cleanup on the immediately
subsequent malloc check too. It'll be in my next merge to Linus, which
should be quite soon - thanks.

--
dwmw2


