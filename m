Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946766AbWKJQ36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946766AbWKJQ36 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 11:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932858AbWKJQ36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 11:29:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:15957 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932857AbWKJQ35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 11:29:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Id8S2AdIos63v4ZB8tDAcMX+V0wP/pLo426Xvbdy9BBBUb6lfRsz4jfPGMmffjeFmYw2ehCaGze7Poy0+0kbTXlNGpOc2wbeJDIgT5WB3+6wg8D5lEgpEFWk6yZw8sSIHx5ydWbBIqz1L5ZbWefkxXZgPdm9sYCSfnsjBkf6xes=
Message-ID: <40f323d00611100829m5fbd32cdt14c307e492df2984@mail.gmail.com>
Date: Fri, 10 Nov 2006 17:29:54 +0100
From: "Benoit Boissinot" <bboissin@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.19-rc5-mm1
Cc: linux-kernel@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>
In-Reply-To: <20061108015452.a2bb40d2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061108015452.a2bb40d2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/06, Andrew Morton <akpm@osdl.org> wrote:
> [snip]
> - The hrtimer+dynticks code still doesn't work right for machines which halt
>   their TSC in low-power states.
>

With CONFIG_NO_HZ=y, xmoto (xmoto.sf.net, a 3d game) is sluggish, the
movement is not fluid (it is "bursty").

.config is at http://perso.ens-lyon.fr/benoit.boissinot/kernel/config-2.6.19-rc5-mm1
lspci -vv: http://perso.ens-lyon.fr/benoit.boissinot/kernel/docked_lspci
dmesg: http://perso.ens-lyon.fr/benoit.boissinot/kernel/dmesg-2.6.19-rc5-mm1

I can test any patch or provide any needed information.

regards,

Benoit
