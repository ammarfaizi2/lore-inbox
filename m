Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287204AbSCRQ7o>; Mon, 18 Mar 2002 11:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289813AbSCRQ7e>; Mon, 18 Mar 2002 11:59:34 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:63361 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S287204AbSCRQ7T>; Mon, 18 Mar 2002 11:59:19 -0500
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help
From: Steven Cole <scole@lanl.gov>
To: Nayyer Tiger <tigerkhan_1@hotmail.com>
Cc: faheemullahkhan101@aol.com, zohair420@hotmail.com, danish4000@hotmail.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <F184dEXWU5oIvIZZwmo0000bd87@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-4mdk 
Date: 18 Mar 2002 10:04:42 -0700
Message-Id: <1016471082.5023.108.camel@spc1.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-03-18 at 04:31, Nayyer Tiger wrote:
> Greetings all,
> 
> I see that in the very latest Configure.help version, 2.76, available at 
> http:/www.tuxedo.org/~esr/cml2/
> Eric has decided to follow the following standard:
> IEC 60027-2, Second edition, 2000-11, Letter symbols to be used in 
> electrical technology - Part 2: Telecommunications and electronics.
> and has changed all the abbreviations for Kilobyte (KB) to KiB, Megabyte 
> (MB) to MiB, etc, etc.
> 
> Now, granted that this is the "standard", should there be some discussion 
> related to this
> change, or is everyone comfortable with this?  It certainly made me do a 
> double take.
> 
> Here is a snippet from the diff between versions 2.75 and 2.76 of 
> Configure.help:
> 
> @@ -344,8 +344,8 @@
>    If you are compiling a kernel which will never run on a machine with
>    more than 960 megabytes of total physical RAM, answer "off" here
>    (default choice and suitable for most users). This will result in a
> -  "3GB/1GB" split: 3GB are mapped so that each process sees a 3GB
> -  virtual memory space and the remaining part of the 4GB virtual memory
> +  "3GiB/1GiB" split: 3GiB are mapped so that each process sees a 3GiB
> +  virtual memory space and the remaining part of the 4GiB virtual memory
>    space is used by the kernel to permanently map as much physical memory
>    as possible.
> 
> Steven

Hey team,

This is the message I posted just before Christmas last year.  The
following thread was quite long and many good arguments were posted pro
and con.  ESR decided to keep the KiB and MiB in Configure.help after
all was said and done, but then Linus split up an older version (v2.69
IIRC) which did not have these changes, performing a "pocket veto" of
the MB to MiB conversion.  Marcello did not accept any changes from ESR
after v2.69 also, so that whole discussion was made rather moot.

So rather than beating up on this horse which was already buried last
year, I suggest spending time more productively.

Steven

