Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbUKBVqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUKBVqy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 16:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbUKBVqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:46:53 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:45837 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262094AbUKBVpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:45:49 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Subject: Re: [rc4-amd64] RC4 optimized for AMD64
Date: Tue, 2 Nov 2004 23:45:38 +0200
User-Agent: KMail/1.5.4
Cc: Marc Bevand <bevand_m@epita.fr>, linux-kernel@vger.kernel.org
References: <cm4moc$c7t$1@sea.gmane.org> <200411020854.21629.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.61.0411021049510.6586@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.61.0411021049510.6586@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411022345.38122.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 November 2004 20:52, dean gaudet wrote:
> On Tue, 2 Nov 2004, Denis Vlasenko wrote:
> 
> > On Monday 01 November 2004 22:44, dean gaudet wrote:
> > > note that 
> > > p4 would prefer "sub $1, %r11b" here instead of dec... but the difference 
> > > is likely minimal.
> > 
> > p4 is not the only x86 CPU on the planet. Why should I use
> > longer instruction then?
> 
> you're asking about spending one byte?  one byte extra for code which 
> could perform better on more CPUs?

You're asking about speedup by 1 cycle on a CPU which will be outdated
6 months from now?
--
vda

