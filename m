Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281780AbRLZQdv>; Wed, 26 Dec 2001 11:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281809AbRLZQdk>; Wed, 26 Dec 2001 11:33:40 -0500
Received: from ns.ithnet.com ([217.64.64.10]:22797 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S281780AbRLZQdd>;
	Wed, 26 Dec 2001 11:33:33 -0500
Date: Wed, 26 Dec 2001 17:33:07 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "James Stevenson" <mistral@stev.org>
Cc: jlladono@pie.xtec.es, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x kernels, big ide disks and old bios
Message-Id: <20011226173307.34e25fe6.skraw@ithnet.com>
In-Reply-To: <001a01c18d77$a9e92ca0$0801a8c0@Stev.org>
In-Reply-To: <3C285B40.91A83EC7@jep.dhis.org>
	<001a01c18d77$a9e92ca0$0801a8c0@Stev.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Dec 2001 19:09:22 -0000
"James Stevenson" <mail-lists@stev.org> wrote:

> Hi
> 
> i have the same problem weith a 40GB disk
> its not a linux problem but a bios / disk problem
> 
> my workaround:
> 
> dont set the jumper on the disk to make it look smaller.
> this however will stop it working in the bios so you need to
> disable the disk in the bios completly and turn off the ide
> auto detection process in the bios this is because it will
> probably hang if you try to use it :)
> 
> linux will then pick the disk up from the ide controller.

I tried this one some time ago, and had to find out, that I was not able to
write to the upper cylinders of the disk. You can check this out _before_ using
the drive via dd from /dev/zero to your /dev/drive and look at the results.

Regards,
Stephan

