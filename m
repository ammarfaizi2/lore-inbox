Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267688AbUHJUJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267688AbUHJUJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267697AbUHJUJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:09:23 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:30143 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S267688AbUHJUJG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:09:06 -0400
Message-ID: <41192B5D.9@free.fr>
Date: Tue, 10 Aug 2004 22:09:01 +0200
From: Eric Valette <eric.valette@free.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Karol Kozimor <sziwan@hell.org.pl>
Subject: Re: 2.6.8-rc4-mm1 : Hard freeze due to ACPI
References: <41189098.4000400@free.fr>  <4118A500.1080306@free.fr>	 <1092151779.5028.40.camel@dhcppc4> <41191929.4090305@free.fr>	 <411927C9.9040300@free.fr> <1092167817.5021.89.camel@dhcppc4>
In-Reply-To: <1092167817.5021.89.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:


> I suppose with the patches available  broken out, you can apply them
> in groups and divide & conquor.

I already spend half the day on this (and the other half installing XP 
SP2 and fixing various issue after sucessfull installation :-))

> I'd be interested to know if the latest bk-acpi.patch is related to
> the issue...

Well, either the bk-acpi.patch for 2.6.8-rc4-mm1 is broken (I mean does 
not contain the right set of fixes) or, as you suggested (and I reached 
the same conclusion while browsing the acpi bitkeeper tree), I reverted 
all the ACPI related patches (bk + another one) to have something that 
should be _exactly_ equivalent to 2.6.8-rc3-mm1.

I've have seen someone on the ACPI mailing list complaining that its 
thermal zone disappear with 2.6.8-rc4-mm1. Maybe some ACPI related table 
get corrupted by someone else...

Last symtom I've found : I also have strange ide error message 
(something like wait for controller to be ready...),

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr





