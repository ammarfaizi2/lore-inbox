Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVAGXdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVAGXdZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVAGXcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:32:46 -0500
Received: from smtp-out4.iol.cz ([194.228.2.92]:30672 "EHLO smtp-out4.iol.cz")
	by vger.kernel.org with ESMTP id S261731AbVAGXcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:32:06 -0500
Message-ID: <41DECD02.2000102@stud.feec.vutbr.cz>
Date: Fri, 07 Jan 2005 18:55:14 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
Cc: Andries Brouwer <aebr@win.tue.nl>, Ron Peterson <rpeterso@mtholyoke.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: /dev/random vs. /dev/urandom
References: <20050107190536.GA14205@mtholyoke.edu> <20050107213943.GA6052@pclin040.win.tue.nl> <Pine.LNX.4.61.0501071729330.22391@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0501071729330.22391@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> Also, the following shows that the AND operation will destroy
> the randomness of the data. In this case I AND with 1, which
> should produce as many '1's as '0's, ... and clearly does not.
> 

It should not. If it always resulted in exactly the same number of '0's 
and '1's then it wouldn't be random. But the relative rate of '0's and 
'1's will approach 50% if the number of tries is statistically 
significant. 32 tries isn't.

Michal
