Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVCLVsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVCLVsd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 16:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVCLVsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 16:48:33 -0500
Received: from fire.osdl.org ([65.172.181.4]:55949 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261389AbVCLVsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 16:48:17 -0500
Message-ID: <4233638F.90308@osdl.org>
Date: Sat, 12 Mar 2005 13:47:59 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Reg Clemens <reg@dwf.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Any way to get larger fonts in XCONFIG ?
References: <200503121912.j2CJCcZN025923@orion.dwf.com>
In-Reply-To: <200503121912.j2CJCcZN025923@orion.dwf.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reg Clemens wrote:
> Any way to get larger fonts with xconfig?
> On my system they are just about microscopic.
> 
> I can do a <ctl><alt?<+> to go to a different screen resolution,
>  but then I have all sorts of scanning to deal with.
> 
> Ive looked for documentation, but didnt find it in any of the
> places I looked...

No automated way to do it AFAIK, but you can edit
~/.qt/qtrc and change this line (at least it works for me):

#font=Sans Serif,10,-1,5,50,0,0,0,0,0
font=Sans Serif,14,-1,5,50,0,0,0,0,0

Changes from 10 point to 14 point font.

-- 
~Randy
