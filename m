Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267494AbTBUPGN>; Fri, 21 Feb 2003 10:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267495AbTBUPGM>; Fri, 21 Feb 2003 10:06:12 -0500
Received: from vbws78.voicebs.com ([66.238.160.78]:59921 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S267494AbTBUPGL>; Fri, 21 Feb 2003 10:06:11 -0500
Message-ID: <3E5642B3.4080104@didntduck.org>
Date: Fri, 21 Feb 2003 10:16:03 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: javaman <javaman@katamail.com>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH 2.5.x, 2.4.x ...] very small
References: <20030221144448Z267481-29901+571@vger.kernel.org>
In-Reply-To: <20030221144448Z267481-29901+571@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

javaman wrote:
> A very small patch (my first patch :-) for Documentation/spinlocks.txt:
> it replace "IFF" with "IF" ;-)
> 
> bye,
> Paolo
> 
> --- Documentation/spinlocks.txt.orig	Fri Feb 21 15:02:01 2003
> +++ Documentation/spinlocks.txt	Fri Feb 21 15:02:44 2003
> @@ -136,7 +136,7 @@
>  
>  If you have a case where you have to protect a data structure across
>  several CPU's and you want to use spinlocks you can potentially use
> -cheaper versions of the spinlocks. IFF you know that the spinlocks are
> +cheaper versions of the spinlocks. IF you know that the spinlocks are
>  never used in interrupt handlers, you can use the non-irq versions:
>  
>  	spin_lock(&lock);
> 

This is wrong.  IFF means "If and only if".

--
				Brian Gerst


