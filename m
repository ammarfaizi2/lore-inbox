Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266330AbRGJOKl>; Tue, 10 Jul 2001 10:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266360AbRGJOKb>; Tue, 10 Jul 2001 10:10:31 -0400
Received: from fe070.worldonline.dk ([212.54.64.208]:5391 "HELO
	fe070.worldonline.dk") by vger.kernel.org with SMTP
	id <S266330AbRGJOKT>; Tue, 10 Jul 2001 10:10:19 -0400
Message-ID: <3B4B28F8.49A6934A@eisenstein.dk>
Date: Tue, 10 Jul 2001 16:10:32 +0000
From: Jesper Juhl <juhl@eisenstein.dk>
Organization: Eisenstein
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: How many pentium-3 processors does SMP support?
In-Reply-To: <Pine.GSO.4.21.0107092315140.493-100000@faith.cs.utah.edu> <9ie450$d1p$1@cesium.transmeta.com> <20010711015128.E31799@weta.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> On Mon, Jul 09, 2001 at 10:34:24PM -0700, H. Peter Anvin wrote:
> 
>     It supports up to 32, if you can find a machine that has that
>     many.
> 
> I think 8-way is about as high as anything common goes to, maybe
> 16. The cpu array is declared 32 long, maybe this should be changed to
> 8 by default?
> 

There are some machines (like the Compaq Proliant ML770 - 
http://www.compaq.com/products/quickspecs/10698_div/10698_div.html) that
are actually sold as 32 way systems based on Pentium III Xeon CPU's, so
why not let the cpu array be able to handle that many CPU's by default
(maybe make a config option?)?


- Jesper Juhl
  juhl@eisenstein.dk
