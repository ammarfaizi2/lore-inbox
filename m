Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312494AbSDJGuf>; Wed, 10 Apr 2002 02:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312497AbSDJGue>; Wed, 10 Apr 2002 02:50:34 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:28178 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S312494AbSDJGud>; Wed, 10 Apr 2002 02:50:33 -0400
Message-Id: <200204100646.g3A6k9X04998@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Jurgen Philippaerts <jurgen@pophost.eunet.be>,
        linux-kernel@vger.kernel.org
Subject: Re: arch/sparc64/kernel/traps.c
Date: Wed, 10 Apr 2002 09:49:22 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020409212000.GK9996@sparkie.is.traumatized.org> <20020409.142329.55241651.davem@redhat.com> <20020409214734.GL9996@sparkie.is.traumatized.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 April 2002 19:47, Jurgen Philippaerts wrote:
> On Tue, Apr 09, 2002 at 11:40:08PM +0200, David S. Miller wrote:
> >    From: Jurgen Philippaerts <jurgen@pophost.eunet.be>
> >    Date: Tue, 9 Apr 2002 23:20:00 +0200
> >
> >    TSTATE: 0000009911009601 TPC: 00000000005a39c0 TNPC: 00000000005a39c4
> >    Y: 00000000    Not tainted
> >
> > Please send this through ksymoops so that we get the kernel
> > symbols that match up to all these magic numbers in your OOPS.
>
> i would, if i could :)
> so, i downloaded ksymoops-2.4.5 (i assume this is the version i need)
>
> but it won't compile. sorry, my c knowledge is very basic.
> but i assume there's something wrong with my /usr/lib/libbfd.a ?

Hi, I had similar problem, took me months to figure it out.
I suggest:
* getting latest binutils, compiling and installing them
* thorougly checking that *old* binutils aren't interfering
  (in my case ksymoops got linked with old libbfd.a despite
  newer one was also installed! 8-[ )
* compiling ksymoops

--
vda
