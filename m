Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279399AbRJWMMR>; Tue, 23 Oct 2001 08:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279400AbRJWMMH>; Tue, 23 Oct 2001 08:12:07 -0400
Received: from hermes.domdv.de ([193.102.202.1]:25610 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S279399AbRJWMMB>;
	Tue, 23 Oct 2001 08:12:01 -0400
Message-ID: <XFMail.20011023141124.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3BD55BE5.2507784F@mandrakesoft.com>
Date: Tue, 23 Oct 2001 14:11:24 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>, andrea@suse.de
Subject: Re: [PATCH] ext2 module build failure (2.4.13pre6)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ouch, make that an aa patch error (2.4.13pre5aa1, sorry, mixed that in,
insufficient caffeine...)

On 23-Oct-2001 Jeff Garzik wrote:
> Andreas Steinmetz wrote:
>> 
>> # nm ./lib/modules/2.4.13-pre6/kernel/fs/ext2/ext2.o | \
>> > grep generic_direct_IO
>>          U generic_direct_IO
>> #
>> 
>> Now what's that? some ghost?
> 
> I guess so :)
> 
Ouch: make that an aa patch error (sorry, mixed that in).

>> [jgarzik@cum linux-2.4.13-pre6]$ bzcat
>> /g/download/kernel/patch-2.4.13-pre6.bz2  | grep generic_direct_IO
>> [jgarzik@cum linux-2.4.13-pre6]$ bzcat
>> /g/download/kernel/linux-2.4.12.tar.bz2 |grep generic_direct_IO
>> [jgarzik@cum linux-2.4.13-pre6]$ grep -r generic_direct_IO .
>> [jgarzik@cum linux-2.4.13-pre6]$ cd ~/cvs/linux_2_4/
>> [jgarzik@cum linux_2_4]$ nm vmlinux | grep generic_direct_IO
>> [jgarzik@cum linux_2_4]$ 
> 
>> 
>> On 23-Oct-2001 Jeff Garzik wrote:
>> > Andreas Steinmetz wrote:
>> >>
>> >> ext2 build as a module fails to missing export of generic_direct_IO which
>> >> the
>> >> attached patch fixes.
>> >>
>> >> <grumble>
>> >> posted this at 2.4.13pre2 time, now we're up to pre6 and nobody cares...
>> >> </grumble>
>> >
>> > Interesting considering this function does not exist at all in
>> > 2.4.13-pre6...
>> >
>> >       Jeff
>> >
>> >
>> > --
>> > Jeff Garzik      | Only so many songs can be sung
>> > Building 1024    | with two lips, two lungs, and one tongue.
>> > MandrakeSoft     |         - nomeansno
>> >
>> >
>> 
>> Andreas Steinmetz
>> D.O.M. Datenverarbeitung GmbH
> 
> -- 
> Jeff Garzik      | Only so many songs can be sung
> Building 1024    | with two lips, two lungs, and one tongue.
> MandrakeSoft     |         - nomeansno
> 
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
