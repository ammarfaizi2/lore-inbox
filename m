Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVFHKoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVFHKoJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 06:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVFHKoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 06:44:09 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:4038 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262165AbVFHKnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 06:43:08 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Ian Kent <raven@themaw.net>, Adrian Bunk <bunk@stusta.de>
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Wed, 8 Jun 2005 13:42:53 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
References: <20050607212706.GB7962@stusta.de> <Pine.LNX.4.58.0506080948540.29656@wombat.indigo.net.au>
In-Reply-To: <Pine.LNX.4.58.0506080948540.29656@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506081342.53864.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 June 2005 04:52, Ian Kent wrote:
> On Tue, 7 Jun 2005, Adrian Bunk wrote:
> 
> > 4Kb kernel stacks are the future on i386, and it seems the problems it 
> > initially caused are now sorted out.
> > 
> > I'd like to:
> > - get a patch into the next -mm that unconditionally enables 4KSTACKS
> > - if there won't be new reports of breakages, send a patch to
> >   completely remove !4KSTACKS for 2.6.13 or 2.6.14
> > 
> > The only drawback is that REISER4_FS does still depend on !4KSTACKS.
> > I told Hans back in March that this has to be changed.
> 
> What about ndiswrapper?
> Why is it so important to make this happen unconditionally?

Number of folks using ndiswrapper for acx100/acx111
while acx team needs help on native driver debugging
worries me.
--
vda

