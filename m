Return-Path: <linux-kernel-owner+w=401wt.eu-S932717AbWLNNjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717AbWLNNjE (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 08:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbWLNNjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 08:39:04 -0500
Received: from il.qumranet.com ([62.219.232.206]:57189 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932717AbWLNNjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 08:39:02 -0500
Message-ID: <458153F3.4040203@argo.co.il>
Date: Thu, 14 Dec 2006 15:38:59 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: =?ISO-8859-1?Q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Userspace I/O driver core
References: <20061214010608.GA13229@kroah.com> <45811D0F.2070705@argo.co.il> <200612141125.14777.hjk@linutronix.de> <45812C17.4090309@argo.co.il> <Pine.LNX.4.61.0612141338490.6223@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0612141338490.6223@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> It has to be written once, but compiled for every kernel
>> version and $arch out there (for out of tree drivers), or it
>> has to wait for the next kernel release and distro sync (for
>> in-tree drivers).
>>     
>
> Still better than written for every _and_ compiled for every.
> But wait, make it simpler: just give the source to the user and
> don't bother with precompiling. It's such a PITA anyhow.
>   

Users don't compile.  They use.  That's why they're called users.

And please don't suggest wrapper scripts to do the compilation.


-- 
error compiling committee.c: too many arguments to function

