Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264825AbUDWOg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264825AbUDWOg1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 10:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264828AbUDWOg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 10:36:27 -0400
Received: from mail2.iserv.net ([204.177.184.152]:15241 "EHLO mail2.iserv.net")
	by vger.kernel.org with ESMTP id S264825AbUDWOg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 10:36:26 -0400
Message-ID: <408929F7.7000307@didntduck.org>
Date: Fri, 23 Apr 2004 10:36:39 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Ballegooijen <sleightofmind@xs4all.nl>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: nvidia binary driver broken with 2.6.6-rc{1,2}, reverting a -mm
 patch makes it work
References: <4088D1E3.1050901@xs4all.nl>
In-Reply-To: <4088D1E3.1050901@xs4all.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Ballegooijen wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi,
> 
> Because of a patch from -mm merged in mainstream i cannot get the nvidia
> binary to work with the 2.6.6 release candidates. I get this message
> when doing `modprobe nvidia`:
> 
> FATAL: Error inserting nvidia (/lib/modules/2.6.6-rc2/video/nvidia.ko):
> Invalid module format
> 
> On advice of mcp i tried reverting the following patch, which made it
> load again.
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc3/2.6.5-rc3-mm4/broken-out/move-__this_module-to-modpost.patch 
> 
> 
> Is there any long-term solution for this comming up? TIA

Could you send me your .config?

--
				Brian Gerst
