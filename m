Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVKBAnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVKBAnx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 19:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbVKBAnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 19:43:53 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:12268 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932086AbVKBAnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 19:43:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=Kw2lzL0hazNeK8bP6npHW/w81Mpn0dGTyeSPh3tm7lWA3gFOmtYjl7TMTx97bEHnDmI/rLnTFuLvV2jYKAMuyO+gQbJ6Ra4eQuFuQ+nXatql64SdUIL9G3bFP5283zdBbzitmt4kM9rpAR6Aqit8TNfzK7ymfakaTgyPOOvPwEQ=
Message-ID: <43680BC0.70805@pol.net>
Date: Wed, 02 Nov 2005 08:43:44 +0800
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [RFC: 2.6 patch] i386: EXPORT_SYMBOL(screen_info) even #ifndef
 CONFIG_VT
References: <20051101152207.GT8009@stusta.de>
In-Reply-To: <20051101152207.GT8009@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: "Antonino A. Daplas" <adaplas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> The folllowing modules require screen_info but don't depend
> on CONFIG_VT:
> - vga16fb.ko
> - intelfb.ko
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Ok with me.

Tony
