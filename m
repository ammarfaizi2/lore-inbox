Return-Path: <linux-kernel-owner+w=401wt.eu-S1751318AbXAUSpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbXAUSpL (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 13:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbXAUSpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 13:45:11 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:53479 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbXAUSpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 13:45:10 -0500
Message-ID: <45B3B50A.7080602@student.ltu.se>
Date: Sun, 21 Jan 2007 19:46:34 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Nicholas Miell <nmiell@comcast.net>
CC: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linville@tuxdriver.com
Subject: Re: [PATCH] Introduce simple TRUE and FALSE boolean macros.
References: <Pine.LNX.4.64.0701210454590.2844@CPE00045a9c397f-CM001225dbafb6> <1169401892.2999.1.camel@entropy>
In-Reply-To: <1169401892.2999.1.camel@entropy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Miell wrote:
> On Sun, 2007-01-21 at 05:03 -0500, Robert P. J. Day wrote:
>   
>>   Introduce the TRUE and FALSE boolean macros so that everyone can
>> stop re-inventing them, and remove the one occurrence in the source
>> tree that clashes with that change.
>>
>>     
>
> If you're going to introduce true and false macros, you should probably
> use the official all-lowercase C99 version.
>   
It is already in there (see include/linux/stddef.h). These are just to 
get rid of the defines of FALSE/TRUE all over the tree.
Not sure why, thou...

