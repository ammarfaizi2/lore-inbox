Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270777AbTGNUDg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270754AbTGNUDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:03:22 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:21491 "EHLO
	mailphish.drugphish.ch") by vger.kernel.org with ESMTP
	id S270777AbTGNUBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:01:32 -0400
Message-ID: <3F130F84.8010104@drugphish.ch>
Date: Mon, 14 Jul 2003 22:16:04 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030611
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alberto Bertogli <albertogli@telpin.com.ar>
Cc: netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPVS' Kconfig LBLC and LBLCR configuration typo
References: <20030714140350.GB1389@telpin.com.ar>
In-Reply-To: <20030714140350.GB1389@telpin.com.ar>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> --- Kconfig.orig	2003-07-14 10:32:06.000000000 -0300
> +++ Kconfig	2003-07-14 10:32:57.000000000 -0300
> @@ -147,7 +147,7 @@
>  	  unsure, say N.
>  
>  config	IP_VS_LBLC
> -	tristate "locality-based least-connection with replication scheduling"
> +	tristate "locality-based least-connection scheduling"
>          depends on IP_VS
>  	---help---
>  	  The locality-based least-connection scheduling algorithm is for
> @@ -163,7 +163,7 @@
>  	  unsure, say N.
>  
>  config  IP_VS_LBLCR
> -	tristate "locality-based least-connection with replication schedulin"
> +	tristate "locality-based least-connection with replication scheduling"
>          depends on IP_VS
>  	---help---
>  	  The locality-based least-connection with replication scheduling

Obviously correct. Dave, if you haven't already, please apply to your 
tree, thanks. We're working on the 2.4.x patch ;).

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

