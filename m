Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313992AbSDKFvS>; Thu, 11 Apr 2002 01:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313993AbSDKFvS>; Thu, 11 Apr 2002 01:51:18 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:58128 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313992AbSDKFvR>; Thu, 11 Apr 2002 01:51:17 -0400
Message-Id: <200204110547.g3B5l3X08802@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Jurgen Philippaerts <jurgen@pophost.eunet.be>,
        linux-kernel@vger.kernel.org
Subject: Re: arch/sparc64/kernel/traps.c
Date: Thu, 11 Apr 2002 08:50:13 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020409212000.GK9996@sparkie.is.traumatized.org> <20020409.155757.34666328.davem@redhat.com> <20020410133908.GJ11858@sparkie.is.traumatized.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 April 2002 11:39, Jurgen Philippaerts wrote:
> On Wed, Apr 10, 2002 at 01:10:10AM +0200, David S. Miller wrote:
> > ksymoops should be already installed on your system
> > at /usr/bin/ksymoops, if it isn't find the package
> > to install or complain to your distribution maintainer :-)
> >
> > If you still want to compile ksymoops from source you need to update
> > and install a new binutils to get the latest BFD library.
>
> allright, ksymoops doesn't come with my distribution (Splack)
> so i got the source, and went from there.
>
> now it compiled nicely.
>
> here's the output that i get (i'm not quite sure what to expect, so i
> hope this is what you need:)

[snip]

> Error (Oops_bfd_perror): set_section_contents Bad value

[snip]

I've seen the same when ksymoops was linked against old libbfd.
It builds without errors but could not disassemble oopsed code.
Check for old libbfd lying around.
--
vda
