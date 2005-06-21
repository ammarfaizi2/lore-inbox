Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVFUUPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVFUUPG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVFUUOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:14:19 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:44711 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261803AbVFUUNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:13:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZGwU+nT6o409+o0AYBJFnfT3W9KcG7Yf9xxSH+KDLImoyIAi9y5HJVuDiDUvSjE8nHZb6W6TIffBhdPrdLfMRZJwf46Yw9YLmxPa9iUjFUdXVSPFDNkgjbdgb0DdwpG40ODcGNMGtoWMorfElguHbMQyHzNAm259phD+sv8Ufu4=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Paolo Marchetti <natryum@gmail.com>
Subject: Re: 2.6.12 cpu-freq conservative governor problem
Date: Wed, 22 Jun 2005 00:19:09 +0400
User-Agent: KMail/1.7.2
Cc: kernel <linux-kernel@vger.kernel.org>
References: <cc27d5b10506180612177415c6@mail.gmail.com>
In-Reply-To: <cc27d5b10506180612177415c6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506220019.09229.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 June 2005 17:12, Paolo Marchetti wrote:
> I'm trying the brand new conservative governor on my p4 2.66 laptop
> ("Intel Pentium 4 clock modulation" only), it doesn't work at all (my
> cpu does not scale).
> 
> cat cpufreq/conservative/sampling_rate_max 
> 2755359744
> 
> cat cpufreq/scaling_max_freq 
> 2666600
> 
> I don't get this...
> ondemand governor works fine as usual.

I've filed a bug at kernel bugzilla, so your report won't be lost.
See http://bugme.osdl.org/show_bug.cgi?id=4772
