Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWARMAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWARMAg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 07:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWARMAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 07:00:36 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:45660 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030187AbWARMAf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 07:00:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UOcesltAjTcvrjLUjVE1n6xDMXHXOFHfX3DBVb+c0XqdPyHdQVQTGV3ABoB5eCqpTmhl/o0HHMWMAiNBIBOkjc/RIerd80ZzDcV3Ihl6q/jUtnA+eVMqIL12Fm9D6klQQAkNO/ToyNgCJttIH9gHa6ls6uBpjMhtJvvyEcbqwmI=
Message-ID: <eb0e02f40601180400k105cb324s596c728dd4846c23@mail.gmail.com>
Date: Wed, 18 Jan 2006 23:00:34 +1100
From: Grant Coady <gcoady@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc1-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060118005053.118f1abc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060118005053.118f1abc.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
On 1/18/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm1/
>
dmesg says a few strange things (this were in 15-mm4 too):
Driver 'w83627hf' needs updating - please use bus_type methods
grant@sempro:~$ dmesg| grep SET
**** SET: Misaligned resource pointer: efe72c22 Type 07 Len 0
**** SET: Misaligned resource pointer: efe72c22 Type 07 Len 0
**** SET: Misaligned resource pointer: efe24582 Type 07 Len 0

plus I had to turn the alsa sound driver off to get the thing to
compile, new for
16-rc1-mm1.

> - There are a lot of reiser3 features and fixes here.  Please test with
>   caution, but please test.

I run reiserfs3, doing allmodconfig now, I'll whinge tomorrow if it
munches the filesystem ;)
<http://bugsplatter.mine.nu/test/boxen/sempro/>

Cheers,
Grant.
