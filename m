Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285014AbRLFGnW>; Thu, 6 Dec 2001 01:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285016AbRLFGnN>; Thu, 6 Dec 2001 01:43:13 -0500
Received: from zok.sgi.com ([204.94.215.101]:1158 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S285013AbRLFGnE>;
	Thu, 6 Dec 2001 01:43:04 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Dhaval Patel" <dhaval@patel.sh>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pcmcia error 
In-Reply-To: Your message of "Tue, 04 Dec 2001 23:20:48 -0000."
             <200112042320.fB4NKmA00501@gateway.patel.sh> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Dec 2001 17:42:53 +1100
Message-ID: <12177.1007620973@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2001 23:20:48 -0000, 
"Dhaval Patel" <dhaval@patel.sh> wrote:
>install the modules with 'make modules_install' it does a bunch of stuff and
>then stops at the following
>
>cd /lib/modules/2.4.16; \
>mkdir -p pcmcia; \
>find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
>if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.16; fi

What do you mean "it stops"?  Do you get any error messages?

