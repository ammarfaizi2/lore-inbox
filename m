Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285095AbRLQMIB>; Mon, 17 Dec 2001 07:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285108AbRLQMHw>; Mon, 17 Dec 2001 07:07:52 -0500
Received: from web21205.mail.yahoo.com ([216.136.131.248]:9609 "HELO
	web21205.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S278660AbRLQMHd>; Mon, 17 Dec 2001 07:07:33 -0500
Message-ID: <20011217120732.18177.qmail@web21205.mail.yahoo.com>
Date: Mon, 17 Dec 2001 04:07:32 -0800 (PST)
From: vijayalakshmi krishnamurthy <linaxmi@yahoo.com>
Subject: Re: prblm with first module prog
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01121712435301.02022@manta>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 Thanx for the reply. it works. but it was only an
offshoot of the problem. I'm not able to find my
module in /proc/module.i cat it. how else should  i
find it? what does the warning say?
I ran it from home dir in vt , not from xterm. shuld i
directly run it in /proc ?
 thanx again.
lakshmi

--- vda <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> On Monday 17 December 2001 08:20, vijayalakshmi
> krishnamurthy wrote:
> 
> > when I redirected my make file o/p from terminal
> only
> > lines 4 - 11 were in the
> >  redirected file. the rest were in the console.
> can
> > somebody explain me the reason.
> >  why do they echo the insmod & rmmod & other
> things? i
> > dont getit.
> 
> make >file 2>file2
>            ^^^^^^^
> redirects stderr to file2
> 
> make >file 2>&1
>            ^^^^
> redirects stderr to stdout, i.e. to file


__________________________________________________
Do You Yahoo!?
Check out Yahoo! Shopping and Yahoo! Auctions for all of
your unique holiday gifts! Buy at http://shopping.yahoo.com
or bid at http://auctions.yahoo.com
