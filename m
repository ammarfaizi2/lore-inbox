Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbUCUWIQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 17:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbUCUWIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 17:08:15 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:33745 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261405AbUCUWIL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 17:08:11 -0500
Message-ID: <405E124D.9030306@free.fr>
Date: Sun, 21 Mar 2004 23:08:13 +0100
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en
MIME-Version: 1.0
To: eric.valette@free.fr, Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc2-mm1 does not boot. 2.6.5-rc1-mm2 + small fix from axboe
 was fine
References: <405DFA02.8090504@free.fr> <Pine.LNX.4.58.0403211555110.28727@montezuma.fsmlabs.com> <405E07A1.9000609@free.fr> <405E0DA8.1060802@free.fr>
In-Reply-To: <405E0DA8.1060802@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Valette wrote:
> Eric Valette wrote:
> 
>> Zwane Mwaikambo wrote:
>>
>>> How about the following patch?
> 
> 
> Does not help. But I guess I've found the problem : the 
> initramfs-search-for init.patch is incorrectly applied in 2.6.5-rc1-mm2 
> patch...

Its a little late here : as you suggested to revert the 
initramfs-search-for-init.patch, I did but got rejected becasue a second 
patch is applied on top of it...

So I will try your patch again on the original rc1-mm2 file. Sorry for 
the trouble (11 PM here)...


-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr



