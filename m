Return-Path: <linux-kernel-owner+w=401wt.eu-S965107AbXADXhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbXADXhd (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 18:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbXADXhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 18:37:33 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:24687 "EHLO
	pd5mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965101AbXADXhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 18:37:32 -0500
Date: Thu, 04 Jan 2007 17:36:03 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: /usr/include/*/acpi.h
In-reply-to: <fa.idYO1X1bcDlMl56ySVF7wfk6M2w@ifi.uio.no>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Petr Baudis <pasky@suse.cz>, Len Brown <lenb@kernel.org>
Message-id: <459D8F63.2020504@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.qisIxqOea5Rsp26DInWsJ/rJdnQ@ifi.uio.no>
 <fa.5repfGqmg59Vyd5d2/q/VejxXRQ@ifi.uio.no>
 <fa.hncOoCGnx5UaIfEWQxbz2N/cObM@ifi.uio.no>
 <fa.ATh7MHfuzpd38JCq6srljq+wqOk@ifi.uio.no>
 <fa.idYO1X1bcDlMl56ySVF7wfk6M2w@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Baudis wrote:
> On Thu, Jan 04, 2007 at 04:15:45PM CET, Len Brown wrote:
>>>> This header files are part of the linux kernel, and thus of course
>>>> available in /usr/include/{asm,linux}.
>> So you pick up all of the kernel include/linux and include/asm*?
>> (but exclude include/acpi/, which is as much a kernel header as the above)
> 
> Yes, we do not exclude any files from the kernel headers package, since
> it is safer to have an extra file there than miss something that
> something in userspace *could* need - or that is not needed now but can
> silently become useful for something userspace in the future. An "all
> headers part of the linux kernel" is much safer definition than "a
> somewhat random selection of kernel headers".

I wouldn't agree with this. We have what headers are to be used in 
userspace now well defined with the "make headers_install" feature in 
the kernel, which is what Fedora Core 6 is basing its kernel headers on. 
Including all headers is simply asking for userspace to use functions, 
etc. from the kernel source which they have no business using.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

