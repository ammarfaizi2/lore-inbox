Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268503AbUHLKla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268503AbUHLKla (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 06:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268504AbUHLKla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 06:41:30 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:19154 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S268503AbUHLKkt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 06:40:49 -0400
Message-ID: <411B492D.4030206@free.fr>
Date: Thu, 12 Aug 2004 12:40:45 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040618
X-Accept-Language: en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Karol Kozimor <sziwan@hell.org.pl>
Subject: Re: 2.6.8-rc4-mm1 : Hard freeze due to ACPI
References: <41189098.4000400@free.fr>  <4118A500.1080306@free.fr>	 <1092151779.5028.40.camel@dhcppc4> <41191929.4090305@free.fr>	 <411927C9.9040300@free.fr> <1092167817.5021.89.camel@dhcppc4>
In-Reply-To: <1092167817.5021.89.camel@dhcppc4>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:

> I'd be interested to know if the latest bk-acpi.patch is related to
> the issue...

I finaly found the time to test it : result is that 2.6.8-rc4 + 
bk-acpi.patch boots fine. The thermal problem is also gone. SO something 
must corrupt the data used by thermal.c in 2.6.8-rc4-mm1 :-(  Did not 
managed to wake up from S3 once. Will retry to be sure...

I think a minimal check on THRM value should be performed (-129°C) is 
crazy as 150 probably...

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr

