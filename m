Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbVKRSEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbVKRSEi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 13:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbVKRSEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 13:04:38 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:61636 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1030266AbVKRSEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 13:04:38 -0500
Message-ID: <437E17B2.9090009@namesys.com>
Date: Fri, 18 Nov 2005 10:04:34 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Adrian Bunk <bunk@stusta.de>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/reiser4/: possible cleanups
References: <20051118033310.GQ11494@stusta.de>	 <437D8FB3.2000108@namesys.com> <1132302717.2830.41.camel@laptopd505.fenrus.org>
In-Reply-To: <1132302717.2830.41.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> gcc can and does optimize static functions more. A function being static
>
>(and not having it's address taken) means that gcc is aware of all
>callers of this one function (unlike non-static obviously where places
>outside the current .c may call it). That knowledge can and is used for
>optimization. (and increasingly so in newer gcc's)
>
>
>
>  
>
Interesting.  We should use static wherever we can then.
