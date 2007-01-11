Return-Path: <linux-kernel-owner+w=401wt.eu-S1030351AbXAKNR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbXAKNR6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 08:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbXAKNR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 08:17:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:47313 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030351AbXAKNR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 08:17:57 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JzmMAzpA5lz8i3J+ujOfdW7/Ht7EszYA1TbP++Lb3C396bmccEvISX2mhyYZtlm+is/F20bY4BoLMDyPdhG86M/JJvQagSqip3OCOXF9EpgqaSZ7bVVhBnIeFw569WxXnFlgG6rON2TLa05BDPEW0I1Y+yUxP9qTpPVYTLht6+U=
Message-ID: <414cba4e0701110517y6c9df6aeqbfa23c9cda3bf2bd@mail.gmail.com>
Date: Thu, 11 Jan 2007 14:17:55 +0100
From: emisca <emisca.ml@gmail.com>
Subject: Re: [Suspend-devel] asus p5ld2 se, serial port gone after suspend and i8042 problems (solved, pnpacpi=off needed)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20070111114202.GC5945@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <414cba4e0701101409w4be38105vae7d185f4c2967bd@mail.gmail.com>
	 <20070111114202.GC5945@elf.ucw.cz>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I have to look at pnpacpi code... but does the dsdt matters for
this problem?
Surely, it is a bios bug (as usually.....). I will look at pnpacpi code.
Does anyone has the same motherboard?

2007/1/11, Pavel Machek <pavel@ucw.cz>:
> Hi!
>
> >    I've got it to work... I've forgot a thing when I tried pnpacpi=off...
> >    I added with grub console temporarly, and in the second boot I forgot
> >    to add it. Booting the kernel (before resume) with pnpacpi=off
> >    definitely make the serial work.
> >    Thanks.. perhaps this is an hack. How we can fix it in a cleaner
> >    way?
>
> Find out what is wrong and patch kernel to fix it? Now you know you
> need to look at pnpacpi code...
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
