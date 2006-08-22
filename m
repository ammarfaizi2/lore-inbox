Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWHVTO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWHVTO6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 15:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWHVTO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 15:14:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:1304 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751106AbWHVTOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 15:14:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=TwePv5StA0uKluJD0TFHVpt88vWqEahvV9X7lZOW993ox4vdwrgqm8oJE3LSx8eJuQU0TbDNnPOW9w628WT8oaYMVnLJUpuf/EwVwKc5e7ZArxqfY2eenUbAVcFFMsWW9bs7vDVBGTBB4+VTztuqS1UD0X9XEENcY4qqB4hp/Kk=
Date: Tue, 22 Aug 2006 21:14:35 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Paul Drynoff <pauldrynoff@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Can not boot linux-2.6.18-rc4-mm2
Message-ID: <20060822211435.GA724@slug>
References: <20060822125118.12ba1ed4.pauldrynoff@gmail.com> <20060822205053.37472ba7.pauldrynoff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822205053.37472ba7.pauldrynoff@gmail.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 08:50:53PM +0400, Paul Drynoff wrote:
> After several attempts of booting I got similar, but not the same message:
> all things are similar like
> last sysfs file: /block/hda/range
> eip, and other registers, but
> process not init:
> Process htplug (pid: 942, ti=c7424000 task=c7420590 task.ti=c7424000)
> 
> Also, I should say that I can reproduce problem on real machine, and on qemu.
Are you able to hook a gdb on qemu ?
Frederik
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
