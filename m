Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318206AbSG3DKS>; Mon, 29 Jul 2002 23:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318210AbSG3DKS>; Mon, 29 Jul 2002 23:10:18 -0400
Received: from gusi.leathercollection.ph ([202.163.192.10]:32452 "EHLO
	gusi.leathercollection.ph") by vger.kernel.org with ESMTP
	id <S318206AbSG3DKR>; Mon, 29 Jul 2002 23:10:17 -0400
Date: Tue, 30 Jul 2002 11:13:21 +0800
From: Federico Sevilla III <jijo@free.net.ph>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Unkillable processes stuck in "D" state running forever
Message-ID: <20020730031321.GH1796@leathercollection.ph>
Mail-Followup-To: Federico Sevilla III <jijo@free.net.ph>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200207290819.g6T8JOT31352@Port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.33L2.0207290908110.23252-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0207290908110.23252-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.4i
X-Organization: The Leather Collection, Inc.
X-Organization-URL: http://www.leathercollection.ph
X-Personal-URL: http://jijo.free.net.ph
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 09:13:33AM -0700, Randy.Dunlap wrote:
> On Mon, 29 Jul 2002, Denis Vlasenko wrote:
> | It is logged by syslog. /var/log/messages if your conf is standard.
> That helps on the output side, sure, but I (mis?)understood the question
> to be about the ability to do Alt-SysRq-x via ssh.  Is that possible?

No you didn't misunderstand my question. Alt-SysRq-x via ssh doesn't
work, and that's what I was wondering about. :)

> Not that I know of, but I could be wrong about that.
> So if you really need Alt-SysRq over a network connection (or even
> a serial console connection)...
> A few months ago I cooked up a patch so that "echo {magickey}"
> mimics SysRq via proc/sysctl.  Patch against 2.4.18 is here:
>   http://www.osdl.org/archive/rddunlap/patches/sys-magic.dif
> Usage is:  echo {key} > /proc/sys/kernel/magickey

I'm curious: can anyone logged on do this? With the physical Alt-SysRq-x
people have to actually go into the server room, up to the server,
connect a keyboard, and do their mumbo-jumbo. With this anybody can say,
unmount all filesystems, right?

:(

But thanks, anyway. I'm thinking about whether or not I should do this
(and just restrict logins to root, or something like that).

 --> Jijo

-- 
Federico Sevilla III   :  <http://jijo.free.net.ph/>
Network Administrator  :  The Leather Collection, Inc.
GnuPG Key ID           :  0x93B746BE
