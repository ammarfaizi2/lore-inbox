Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264813AbSJaU6r>; Thu, 31 Oct 2002 15:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264861AbSJaU6q>; Thu, 31 Oct 2002 15:58:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11018 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264813AbSJaU6q>;
	Thu, 31 Oct 2002 15:58:46 -0500
Message-ID: <3DC19ACA.9030906@pobox.com>
Date: Thu, 31 Oct 2002 16:04:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM REPORT 2.4.20-rc1: sundance.c
References: <20021031173834.4514603a.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:

>Hello all,
>
>I'd like to point out that (at least) the network driver sundance.c has weird
>flaws when trying to use more than MAX_UNITS (8) cards at the same time. Since
>

Smileys nonwithstanding, you need to include far more information

Please define "weird flaws"... explicitly.

>this driver can be used for DFE-580TX 4 port network card it is really easy to
>get more than 8 ports :-)
>In fact the driver does check against MAX_UNITS, but does _not_ fail if you go
>through the roof. Instead you can expect really interesting ifconfig-outputs
>;-)
>IMHO it should check and fail. I wonder what other card drivers do in such a
>case ...
>  
>

Other card drivers handle this case just fine.  The expected behavior is 
that module options will only support up to MAX_UNITS of certain 
arguments, but beyond that nothing is affected at all.

    Jeff




