Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315740AbSECXGk>; Fri, 3 May 2002 19:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315741AbSECXGj>; Fri, 3 May 2002 19:06:39 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:46557 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S315740AbSECXGj>; Fri, 3 May 2002 19:06:39 -0400
Message-ID: <3CD316C8.5040006@oracle.com>
Date: Sat, 04 May 2002 01:01:28 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020326
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org
Subject: Re: IDE
In-Reply-To: <UTC200205032240.g43Meuf15031.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> < Recap >
> 
> == I have had problems with 2.5.10 (first few blocks of the root
> == filesystem overwritten) and then went back to 2.5.8 that I had
> == used for a while already, but then also noticed corruption there.
> == Back at 2.4.17 today..
> 
> < Optimistic reply >
> 
> = It could very well be that the recent changes could have cured this.
> 
> < Reality of today >
> 
> Booted a vanilla 2.5.12. It did not succeed in mounting the root
> filesystem, but instead wrote zeros over the superblock.
> 
> 	hdb: task_out_intr: error=0x04 { DriveStatusError }
> 
> Will try 2.5.13 later.

Managed to boot all versions (though some ext3 journal replay
  showed up even after clean shutdowns), seems to be okay and
  mashed my disk with installing of Portal today - no issue,
  only a positive note for the 2.5.13 VM which allowed me to
  finish in 48' what 2.4.19-pre7 couldn't finish in over 2h.

Dell laptop with a PIIX4 chipset, btw.

--alessandro

  "the hands that build / can also pull down
    even the hands of love"
                             (U2, "Exit")

