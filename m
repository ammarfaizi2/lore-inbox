Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129905AbRAWO7G>; Tue, 23 Jan 2001 09:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130105AbRAWO6r>; Tue, 23 Jan 2001 09:58:47 -0500
Received: from mail.digitalme.com ([193.97.97.75]:46085 "EHLO digitalme.com")
	by vger.kernel.org with ESMTP id <S129905AbRAWO60>;
	Tue, 23 Jan 2001 09:58:26 -0500
Message-ID: <3A6D9BE6.8070400@bigfoot.com>
Date: Tue, 23 Jan 2001 09:57:42 -0500
From: "Trever L. Adams" <trever_Adams@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; m18) Gecko/20010122
X-Accept-Language: en
MIME-Version: 1.0
To: Patrizio Bruno <patrizio@dada.it>
CC: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Total loss with 2.4.0 (release)
In-Reply-To: <Pine.LNX.4.10.10101231129450.22934-100000@blacksheep.at.dada.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrizio Bruno wrote:

> I think that your linux's partition has not been overwritten, but only the MBR
> of your disk, so you probably just need to reinstall lilo. Insert your
> installation bootdisk into your pc, then skip all the setup stuff, but the
> choose of the partition where you want to install and the source from where
> you want to install, then select just the lilo configuration (bootconfiguration
> I mean), complete that step and reboot your machine, lilo will'be there again.
> 
> P.
> 
> On Tue, 23 Jan 2001, Trever L. Adams wrote:

I hate to tell you this, but you couldn't be more wrong.  My MBR was 
fine.  Lilo was fine and ran fine.  The kernel even booted. The problem 
was my ext2 partition was scrambled but good (over 4 hours trying to fix 
it and answer all the questions that fsck threw out).  The ext2 drive 
lost a lot of data and suddenly had windows stuff all over it (yes, just 
like Mike, I had ttf fonts and other such things).

Trever

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
