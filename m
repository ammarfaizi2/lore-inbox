Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbTLMDBT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 22:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbTLMDBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 22:01:19 -0500
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:44204 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S261298AbTLMDBS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 22:01:18 -0500
Message-ID: <3FDA8199.5090804@stesmi.com>
Date: Sat, 13 Dec 2003 04:03:53 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: surya prabhakar <surya_prabhakar@linuxmail.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Intel 82801EB chipset issue
References: <20031213024621.25246.qmail@linuxmail.org>
In-Reply-To: <20031213024621.25246.qmail@linuxmail.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

surya prabhakar wrote:

> Dear All ,
>     I have an IBM Mpro with Intel 875p motherboard with SATA (ICH5 ) 82801EB chip on it . THe problem is this chipset is not recognised in redhat 7.3 , does not get installed ,it cannot find the neither harddrive or cdrom drives ( IDE only not SATA ) . I need it working on redhat 7.3 (2.4.18-3) . Any suggestive patch /work-around will be highly appreciated .
> 
> Thanks and regards
> 
> Surya Prabhakar N ,
> Technical Specialist ,
> Strategy & Deployment Team ,
> Wipro Limited ,
> Bangalore - India.
> 

You have a few options:

1) Install on another drive, get latest kernel.org kernel, add
libata support to it. Recompile it, install it, run it.
Copy system to SATA drive. Use it.

2) Install on another drive, get latest Fedora Core 1 kernel,
recompile it after disabling ntpl support in it. Install and run
kernel.Copy system to SATA drive. Use it.

3) Install something else (For instance Fedora Core 1) that has
native support for that controller.

"Another drive" means "another machine" btw. One that is supported.

// Stefan

