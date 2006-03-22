Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWCVQLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWCVQLN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWCVQLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:11:13 -0500
Received: from terminus.zytor.com ([192.83.249.54]:14724 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751314AbWCVQLL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:11:11 -0500
Message-ID: <44217714.6050004@zytor.com>
Date: Wed, 22 Mar 2006 08:11:00 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Antonio Vargas <windenntw@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Merge strategy for klibc
References: <441F0859.2010703@zytor.com>	 <Pine.LNX.4.64.0603202228441.17704@scrub.home>	 <dvq5km$o0g$1@terminus.zytor.com> <69304d110603220647o3b91140audfcd5e211e7b0b71@mail.gmail.com>
In-Reply-To: <69304d110603220647o3b91140audfcd5e211e7b0b71@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonio Vargas wrote:
> 
> Regarding helping test/develop this, is there any small distro already
> using klibc for such purposes? Maybe you, hpa, could share you klibc
> testing rig? This looks ripe for a qemu-based testing at the moment,
> not being performance critical like many other current developments...
> 

The klibc-integrated git tree is at:

git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-2.6-klibc.git

At this point, the big thing is to drop this into as many 
weirdly-booting Linux setups as possible, and watch them hopefully have 
no effect whatsoever :)

For porting klibc, I have a set of tests which are also included. 
Unfortunately, they're not currently self-validating, which would be a 
significant enhancement.

	-hpa
