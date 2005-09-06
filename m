Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbVIFEeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbVIFEeW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 00:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVIFEeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 00:34:22 -0400
Received: from highlandsun.propagation.net ([66.221.212.168]:39954 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S1751314AbVIFEeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 00:34:21 -0400
Message-ID: <431D1C3F.6090302@symas.com>
Date: Mon, 05 Sep 2005 21:34:07 -0700
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b4) Gecko/20050829 SeaMonkey/1.1a
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6, devfs, SMP, SATA
References: <d2a0e906050903212678ad88a1@mail.gmail.com>	 <81b0412b0509041529524bca1f@mail.gmail.com>	 <431B7BE2.9070806@symas.com> <84144f02050905055633713bd3@mail.gmail.com>
In-Reply-To: <84144f02050905055633713bd3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> On 9/5/05, Howard Chu <hyc@symas.com> wrote:
>   
>> So, any guesses why with otherwise identical config options, a kernel
>> with SMP enabled doesn't boot up with all of the device nodes that it
>> should? (Both drives are on the same controller. I haven't checked to
>> see if any other device files are missing.)
>>     
>
> Devfs is disabled in 2.6.13 as it most likely will be going away soon.
> See http://marc.theaimsgroup.com/?l=linux-kernel&m=111939455921877&w=2.
>   
Thanks for the note. I guess I meant udev, or whatever it is that 
populates /dev these days.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

