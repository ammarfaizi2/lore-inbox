Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbVERXPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbVERXPN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 19:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVERXPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 19:15:13 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:11489 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S262404AbVERXPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 19:15:07 -0400
Message-ID: <428BCC63.4070101@nortel.com>
Date: Wed, 18 May 2005 17:14:43 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@lovecn.org>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] time_after_eq fix
References: <20050518224415.GA5768@lovecn.org>
In-Reply-To: <20050518224415.GA5768@lovecn.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> Hello,
> 
> The two macros time_after and time_after_eq were added to do wrapping
> correctly, but only time_after does it the right way, time_after_eq has
> been wrong since the very beginning(v2.1.127, 07-Nov-1998).

> -	 ((long)(a) - (long)(b) >= 0))
> +	 ((long)(b) - (long)(a) <= 0))

Why does it matter which way you do it?  In what circumstances does your 
code give a different answer?


Chris
