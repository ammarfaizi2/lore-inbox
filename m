Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVGFTsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVGFTsY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbVGFTqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:46:14 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:10402 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262362AbVGFOxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 10:53:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jY7OTCXmxVlsOcwLgw1wGgE9bQ90vZxMtZAlDh1pwWcNb88sFnRaTsEJ328/QzhgQrvuWX+NUZGDDelxpeaYX0PwD12fmt1h80lk5H6zkjqRA8SJndCEoL5/UAwjQTK4sMeV74xlmBHjoFj1ggpxoStG/T+lF8gHdCR7NEMigTE=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jeremy Laine <jeremy.laine@polytechnique.org>
Subject: Re: OOPS: frequent crashes with bttv in 2.6.X series (inc. 2.6.12)
Date: Wed, 6 Jul 2005 18:59:39 +0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <1120644686.42cbae4e16ea3@webmail.jerryweb.org>
In-Reply-To: <1120644686.42cbae4e16ea3@webmail.jerryweb.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507061859.40565.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 July 2005 14:11, Jeremy Laine wrote:
> I keep getting OOPS's when using a Bt878 TV card, I am basically unable to watch
> TV for more than about 20-30mn without my system grinding to a halt.

> I have seen suggestions to try without PREEMPT enabled, which I will be doing
> shortly. Any other suggestions to get to the bottom of this problem are most
> welcome!

Try without loading all those proprietary modules (vmmon, vmnet, nvidia).

> Jul  6 10:55:44 sharky kernel: EIP:    0060:[__link_path_walk+1862/3520]   
> Tainted: P      VLI
