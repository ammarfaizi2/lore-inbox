Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSDVX3j>; Mon, 22 Apr 2002 19:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314939AbSDVX3i>; Mon, 22 Apr 2002 19:29:38 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:16402 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314938AbSDVX3f>;
	Mon, 22 Apr 2002 19:29:35 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: wichert@cistron.nl (Wichert Akkerman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS in the main kernel 
In-Reply-To: Your message of "22 Apr 2002 18:55:20 +0200."
             <aa1f9o$519$1@picard.cistron.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Apr 2002 09:29:22 +1000
Message-ID: <6047.1019518162@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Apr 2002 18:55:20 +0200, 
wichert@cistron.nl (Wichert Akkerman) wrote:
>In article <3CC427F4.12C40426@fnal.gov>,
>Dan Yocum  <yocum@fnal.gov> wrote:
>>I know it's been discussed to death, but I am making a formal request to you
>>to include XFS in the main kernel.  We (The Sloan Digital Sky Survey) and
>>many, many other groups here at Fermilab would be very happy to have this in
>>the main tree.  
>
>Has XFS been proven to be completely stable

As much as any other filesystem.  "There are no bugs in filesystem XYZ.
That just means that you have not looked hard enough." :)  There is a
daily QA suite that XFS is run through.

>The reason I am asking is that XFS seems to be a fairly common
>factor for segfault bugreports in dpkg.

dpkg uses mmap?  There was a bug in XFS and mmapped files where
incorrect blocks were flushed to disk under high load, but that was
fixed around January 30.

--

Not speaking for sgi.

