Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285492AbRLYMDY>; Tue, 25 Dec 2001 07:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285484AbRLYMDO>; Tue, 25 Dec 2001 07:03:14 -0500
Received: from web20305.mail.yahoo.com ([216.136.226.86]:14087 "HELO
	web20305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S285492AbRLYMDD>; Tue, 25 Dec 2001 07:03:03 -0500
Message-ID: <20011225120303.99542.qmail@web20305.mail.yahoo.com>
Date: Tue, 25 Dec 2001 04:03:03 -0800 (PST)
From: Amber Palekar <amber_palekar@yahoo.com>
Subject: Re: syscall from modules
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <01122513462001.02101@manta>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
   if i export these syms .. firstly ill have to
change the source/patch the kernel which is not
advisable then every time i write such a module .. ill
have to make sure that i export all these symbols and
there are no conflicts due to some wierd deps that
might be present ( u never know ! ) So i am looking
for a descent way to do the same

Still in need of help,
Amber 

--- vda <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> On Tuesday 25 December 2001 09:31, Amber Palekar
> wrote:
> >  Hi,
> >    I am trying to write a linux kernel module.I
> want
> >  to  use sys_sendto,sys_recvfrom etc calls from
> the
> >  module.However these symbols are not present in
> >  'ksyms'.One sluggish option is to modify socket.c
> (
> >  which contains these function definitions ) to
> >  export  the symbols. However this would require
> > comiling the  entire kernel.Is there a descent way
> to
> > do this ??
> 
> I don't know much about module writing.
> Why do you think it's wrong to export those fns?
> --
> vda


__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com
