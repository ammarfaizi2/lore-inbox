Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbVAURPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVAURPT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 12:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbVAURPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 12:15:19 -0500
Received: from fire.osdl.org ([65.172.181.4]:63431 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262423AbVAURPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 12:15:12 -0500
Message-ID: <41F134DC.8020204@osdl.org>
Date: Fri, 21 Jan 2005 08:59:08 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
CC: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: FATAL: Error inserting fm -- invalid module format
References: <4EE0CBA31942E547B99B3D4BFAB348112B93D8@mail.esn.co.in>
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348112B93D8@mail.esn.co.in>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srinivas G. wrote:
> Dear All,
> 
> We were developed a block device driver on linux-2.6.x kernel. We want
> to distribute our driver as a RPM Binary. We are using the SuSE 9.1 with
> 2.6.5-7.71 kernel.
> 
> We build the RPM file using the fm.ko file on SuSE 9.1 with 2.6.5-7.71
> kernel where fm.ko indicates our Block Driver module.  When I try to run
> the RPM file on a different kernel version it has given the following
> error message.
> 
> FATAL: Error inserting fm
> (/lib/modules/2.6.4-52-default/kernel/drivers/block/fm.ko): Invalid
> module format
> 
> As I know the error message indicates that I compiled the driver under
> 2.6.5-7.71 kernel where as I am trying to insert the module in
> 2.6.4-52-default kernel.
> 
> My question is: Is it possible to compile and build a .ko file with out
> including the version information? (i.e. I want to build a RPM file
> using fm.ko file which was compiled using 2.6.5-7.71 and to run the RPM
> file on a different kernel versions.)
> 
> We are not very sure of how to achieve this. 
> Please help us address this issue.

So you want to get around a mechanism that is preventing your driver
from causing an Oops because of different data structures, different
kernel APIs, etc., between those version?  or any versions?

This is just asking for trouble.  IOW, forget it.

-- 
~Randy
