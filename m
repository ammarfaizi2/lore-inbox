Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271344AbRIAU37>; Sat, 1 Sep 2001 16:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271336AbRIAU3j>; Sat, 1 Sep 2001 16:29:39 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:62224 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S271344AbRIAU31>;
	Sat, 1 Sep 2001 16:29:27 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Samium Gromoff <_deepfire@mail.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: is bzImage container large enough? 
In-Reply-To: Your message of "Sat, 01 Sep 2001 16:28:06 GMT."
             <200109011628.f81GS6R01079@vegae.deep.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 02 Sep 2001 06:29:41 +1000
Message-ID: <22500.999376181@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Sep 2001 16:28:06 +0000 (UTC), 
Samium Gromoff <_deepfire@mail.ru> wrote:
>      If one wanting to turn on virtually every kernel CONFIG_* option
>  in order to check if the kernel compiles and then report possible
>  gcc errors to lkml, will the resulting kernel fit the bzImage format?

No, it is far too big.

BTW, if you want to test compiles against various combinations of
config, there are kbuild patches that add make allyes, make allno, make
allmod and make randconfig.  Included in separate mail.

