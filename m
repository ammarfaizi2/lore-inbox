Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbVIHVLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbVIHVLo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 17:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbVIHVLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 17:11:43 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:22503 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751399AbVIHVLn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 17:11:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CuVnuRIlpw5g3Wl4XTqeUJuF1GLyvQoTypiwBr9YTNq2xE+KIjBooa2FdF/vA7LzTwT7Zon4XfCG10JwNMrGWyjuY7PSyAB+3LFJRquSMBPjOOUUkmKW3p41GnCepKr9sEVxNVQvhA4UiUVOpy3LPdPjoPelza2A6VRu0lY4BpY=
Message-ID: <c775eb9b05090814114f258dc9@mail.gmail.com>
Date: Thu, 8 Sep 2005 17:11:42 -0400
From: Bharath Ramesh <krosswindz@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: IPW2100 Kconfig
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050908080106.GB773@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <005101c5b311_4ca69a50_a20cc60a@amer.sykes.com>
	 <20050908080106.GB773@openzaurus.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AFAIK hotplug looks for firmware in /lib/firmware and not /etc/firmware.

On 9/8/05, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
> 
> >       I checked the IPW2100 in the current git from linux-2.6 and the menuconfig
> > help (Kconfig) says you need to put the firmware in /etc/firmware, it should
> > be /lib/firmware.
> >
> > Who should I send the "patch" to? Or can someone simply change that?
> 
> Are you sure it is not distro-dependend?
> --
> 64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
