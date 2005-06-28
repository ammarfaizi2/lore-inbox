Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVF1O50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVF1O50 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVF1O50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:57:26 -0400
Received: from [195.23.16.24] ([195.23.16.24]:14502 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262004AbVF1Oza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:55:30 -0400
Message-ID: <42C164E1.6000506@grupopie.com>
Date: Tue, 28 Jun 2005 15:55:29 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
Cc: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kswapd flaw
References: <200506280637.JAA07333@raad.intranet>
In-Reply-To: <200506280637.JAA07333@raad.intranet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> On Mon, Jun 27, 2005 at 11:04:08PM +0300, Al Boldi wrote:
> 
>>In 2.4.31 kswapd starts paging during OOMs even w/o swap enabled.
>>
>>Is there a way to fix/disable this behaviour?
> 
> 
> Marcelo,
> 
> Kswapd starts evicting processes to fullfil a malloc, when it should just
> deny it because there is no swap.

I think what you really want is to adjust your "overcommit" settings.

See: "Documentation/vm/overcommit-accounting"

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams
