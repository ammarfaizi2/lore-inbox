Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287827AbSBCW0C>; Sun, 3 Feb 2002 17:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287831AbSBCWZw>; Sun, 3 Feb 2002 17:25:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21252 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287827AbSBCWZs>; Sun, 3 Feb 2002 17:25:48 -0500
Message-ID: <3C5DB8B7.4030304@zytor.com>
Date: Sun, 03 Feb 2002 14:24:55 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Rob Landley <landley@trommello.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        "Erik A. Hendriks" <hendriks@lanl.gov>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Werner Almesberger <wa@almesberger.net>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org> <m1y9ia76f7.fsf@frodo.biederman.org> <3C5D91EB.4000900@zytor.com> <20020203221750.HMXG18301.femail20.sdc1.sfba.home.com@there>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

> 
> And el-torito bootable CDs basically glue a floppy image onto the front of 
> the CD and lie to the bios to say "oh yeah, I'm a floppy, boot from me".  
> Luckily, they can use the old 2.88 "extended density" floppy standard IBM 
> tried to launch years ago which never got anywhere, but which most BIOS's 
> recognize.  But that's still a fairly small place to try to stick a whole 
> system...
> 


They can be; they can also run in a mode where they can access arbitrary 
blocks on the CD (ISOLINUX runs in this mode.)

	-hpa


