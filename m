Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270007AbUJSWY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270007AbUJSWY0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269926AbUJSWXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:23:50 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:53658 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S269928AbUJSWWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:22:52 -0400
From: Russell Miller <rmiller@duskglow.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: 2.6.9 DRM compile problem
Date: Tue, 19 Oct 2004 17:26:37 -0500
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200410191613.35691.rmiller@duskglow.com> <1A4F78A9-221D-11D9-8195-000393ACC76E@mac.com>
In-Reply-To: <1A4F78A9-221D-11D9-8195-000393ACC76E@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410191726.37695.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 October 2004 17:20, Kyle Moffett wrote:

>   config DRM_GAMMA
>   	tristate "3dlabs GMX 2000"
> -	depends on DRM
> +	depends on DRM && BROKEN
>   	help
>   	  This is the old gamma driver, please tell me if it might actually
>   	  work.
>
> The gamma driver was broken to restore the sanity of DRM.  In
> fact, the only way to actually even try to build it is to turn on the
> config option "Include incomplete/broken drivers"
>
That does answer my question as to where to find out.  Thanks.

--Russell

-- 

Russell Miller - rmiller@duskglow.com - Le Mars, IA
Duskglow Consulting - Helping companies just like you to succeed for ~ 10 yrs.
http://www.duskglow.com - 712-546-5886
