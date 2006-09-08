Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWIHKpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWIHKpn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 06:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWIHKpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 06:45:43 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:1188 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S1750733AbWIHKpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 06:45:41 -0400
In-Reply-To: <44FEE554.5050903@rapidforum.com>
References: <44FEE554.5050903@rapidforum.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <46D15876-B70D-421D-B16E-247CC3ADD1B8@bootc.net>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Chris Boot <bootc@bootc.net>
Subject: Re: Large Block Devices not supported in 64 bit
Date: Fri, 8 Sep 2006 11:45:36 +0100
To: Christian Schmid <webmaster@rapidforum.com>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Sep 2006, at 16:12, Christian Schmid wrote:

> Hello.
>
> I run kernel 2.6.17.11 vanilla in 64 bit mode with 32 bit emulation.
>
> Unfortunately there is no support for file-systems bigger than 2 TB  
> in 64 bit mode.

There is. There just isn't any support for having the feature turned  
off. After all, the code needed on 32-bit systems to have large files  
(64-bit file offsets) isn't necessary on 64-bit systems: file offsets  
are already 64-bit by nature.

HTH,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/


