Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267873AbTBRPpD>; Tue, 18 Feb 2003 10:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267874AbTBRPpD>; Tue, 18 Feb 2003 10:45:03 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26250
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267873AbTBRPpC>; Tue, 18 Feb 2003 10:45:02 -0500
Subject: Re: [PATCH]: M5451 (OSS trident.c) did not come out of reset
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030218151138.GU2492@actcom.co.il>
References: <20030218151138.GU2492@actcom.co.il>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045587412.24171.39.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 18 Feb 2003 16:56:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-18 at 15:11, Muli Ben-Yehuda wrote:

> The 2.4 behaviour is to continue as usual even if the card doesn't
> come out of reset, because it's a non fatal error on at least some
> cards. This patch reverts the behaviour to the 2.4 behaviour, which
> works for me. If anyone knows how to tell for a given card whether
> this is a fatal error or not, please let me know and I'll update the
> patch.  

Looks fine. 2.4 went from short delay -> long with check -> long with check
counted non fatal. The trick used to check the codec came up doesnt work
for all codecs alas. Fix is fine

Alan

