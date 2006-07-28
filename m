Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWG1BH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWG1BH4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 21:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbWG1BHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 21:07:55 -0400
Received: from main.gmane.org ([80.91.229.2]:11485 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750999AbWG1BHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 21:07:55 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Linux v2.4.33-rc3 (and a new v2.4 maintainer)
Date: Thu, 27 Jul 2006 21:11:16 -0400
Message-ID: <44C96434.9040202@tmr.com>
References: <20060727213019.GA10677@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Gmane-NNTP-Posting-Host: mail.tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
In-Reply-To: <20060727213019.GA10677@dmt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Hi,
> 
> Here goes the third (and hopefully last) release candidate of v2.4.33.
> 
> It contains a fix for CVE-2006-2935 (locally exploitable typo in DVD
> code), ethtool oopses and an ext3 block bitmap leakage issue.
> 
> Willy Tarreau has stepped up to maintain the mainline v2.4 tree, and
> will do so starting from v2.4.34.
> 
> He has devoted great effort to help maintenance for the past few years.
> His -hotfix tree is quite popular amongst v2.4 users, for instance.
> 
> I feel very confident in his competence for the job, knowing his good
> common sense and great technical/communication skills.

Thanks to both of you, I know a number of people who are still on 2.4 
due to issues with the new development model, they all depend on you for 
stable kernel fixes.
> 
> Thanks Willy!
> 
> 
> Summary of changes from v2.4.33-rc2 to v2.4.33-rc3
> ============================================
> 
> Andreas Haumer:
>       [PATCH-2.4] Typo in cdrom.c
> 
> Kirill Korotaev:
>       EXT3: ext3 block bitmap leakage
> 
> Marcelo Tosatti:
>       Change VERSION to 2.4.33-rc3
> 
> Willy Tarreau:
>       ethtool: two oopses in ethtool_set_coalesce() and ethtool_set_pauseparam()
> 


-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

