Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316196AbSEKCs7>; Fri, 10 May 2002 22:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316197AbSEKCs5>; Fri, 10 May 2002 22:48:57 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:43782 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316196AbSEKCs5>;
	Fri, 10 May 2002 22:48:57 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iget-locked [2/6] 
In-Reply-To: Your message of "Fri, 10 May 2002 21:21:16 EST."
             <Pine.LNX.4.44.0205102120210.11642-100000@chaos.physics.uiowa.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 May 2002 12:48:46 +1000
Message-ID: <3950.1021085326@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002 21:21:16 -0500 (CDT), 
Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:
>On Sat, 11 May 2002, Keith Owens wrote:
>
>> Build time is the least of your worries here.  All objects that export
>> symbols must have unique basenames, all the modversion crud goes in
>> include/linux/modules under the object's basename.
>
>This is not true anymore in 2.5, this limitation was removed when ALSA 
>went in.

True, but if the iget change goes into 2.5 it will probably be
backported to 2.4 later, 2.4 still has the restriction.

As for modversions on 2.5, well you know my opinion ;).

