Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265677AbSKKP0N>; Mon, 11 Nov 2002 10:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbSKKP0N>; Mon, 11 Nov 2002 10:26:13 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:52234 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265677AbSKKP0M>;
	Mon, 11 Nov 2002 10:26:12 -0500
Date: Mon, 11 Nov 2002 16:32:36 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Brian Jackson <brian@brianandsara.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46-bk6 kconfig errors
Message-ID: <20021111153236.GA1023@mars.ravnborg.org>
Mail-Followup-To: Brian Jackson <brian@brianandsara.net>,
	linux-kernel@vger.kernel.org
References: <3DCF24CE.7090405@brianandsara.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DCF24CE.7090405@brianandsara.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 09:32:30PM -0600, Brian Jackson wrote:
> Just downloaded bk6 and I get the following errors when I do a make 
> menuconfig. Same thing happens whether I have a  .config already or not. 

Glancing through the errors you get, the conf.c file you have
is not the same as is present in 2.5.47.

> scripts/kconfig/conf.c:1: parse error before '=' token
No '=' on line 1

> scripts/kconfig/conf.c:21: parse error before '!=' token
No '!=' on line 21

> scripts/kconfig/conf.c:30: warning: implicit declaration of function 
> `XFS_ERROR'
No XFS_ERROR in the file.

etc. etc.

It looks to me you have a wrong file in place of conf.c.
Or maybe a filesystem error?

	Sam
