Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWBMRsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWBMRsB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWBMRsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:48:01 -0500
Received: from terminus.zytor.com ([192.83.249.54]:13224 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932274AbWBMRsA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:48:00 -0500
Message-ID: <43F0C61C.2050207@zytor.com>
Date: Mon, 13 Feb 2006 09:47:08 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Michlmayr <tbm@cyrius.com>
CC: klibc list <klibc@zytor.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [klibc] klibc tree status
References: <43F010F3.5030305@zytor.com> <20060213114340.GC32626@deprecation.cyrius.com>
In-Reply-To: <20060213114340.GC32626@deprecation.cyrius.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Michlmayr wrote:
> * H. Peter Anvin <hpa@zytor.com> [2006-02-12 20:54]:
> 
>>I have *NOT* implemented support for the following, which I'm hoping
>>has fallen out of use by now:
>>
>>	-> When loading the ramdisk from a block device, stop and
>>	   ask the user for a second disk.
> 
> 
> This is most certainly still being used, e.g. in Debian to allow
> starting the installer from floppy disks.

Well, I just pushed out a klibc/kinit tree which should have this 
functionality (untested, however.)  Unlike the mainstream kernel, this 
should work for kinit even when the ramdisk is compressed.

	-hpa
