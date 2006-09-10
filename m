Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWIJSCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWIJSCt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 14:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWIJSCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 14:02:49 -0400
Received: from terminus.zytor.com ([192.83.249.54]:30695 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932344AbWIJSCs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 14:02:48 -0400
Message-ID: <45045335.1070406@zytor.com>
Date: Sun, 10 Sep 2006 11:02:29 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reserve a boot-loader ID number for Xen
References: <45035472.8000506@goop.org> <20060910012029.GA26959@redhat.com> <45036A5B.3070402@goop.org>
In-Reply-To: <45036A5B.3070402@goop.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> Dave Jones wrote:
>>  >                  4 for ETHERBOOT
>>  > +                5 for ELILO
>>  > +                7 for GRuB
>>  > +                8 for U-BOOT
>>  > +                9 for Xen
>>  >                  V = version
>>  >  0x211    char        loadflags:
>>
>> Is there a reason 6 has been skipped ?
>>   
> 
> HPA told me to use 9.  Maybe there's an unofficial user for 6?
> 

6 was skipped because I couldn't rule out that it hadn't been 
unofficially used.  It seemed easier to skip it for now.

	-hpa
