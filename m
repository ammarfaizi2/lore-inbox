Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVJSLhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVJSLhI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVJSLhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:37:07 -0400
Received: from cncln.online.ln.cn ([218.25.172.144]:49166 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1750729AbVJSLhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:37:06 -0400
Date: Wed, 19 Oct 2005 19:36:53 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Mathieu Segaud <matt@regala.cx>
Cc: Erik Mouw <erik@harddisk-recovery.com>,
       Karel Kulhavy <clock@twibright.com>, linux-kernel@vger.kernel.org
Subject: Re: number of eth0 device
Message-ID: <20051019113653.GA3621@localhost.localdomain>
References: <20051019103135.GA9765@kestrel> <20051019104240.GC31526@harddisk-recovery.com> <87psq1da2j.fsf@barad-dur.minas-morgul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87psq1da2j.fsf@barad-dur.minas-morgul.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2005 at 01:23:48PM +0200, Mathieu Segaud wrote:
> Erik Mouw <erik@harddisk-recovery.com> disait dernièrement que :
> 
> > On Wed, Oct 19, 2005 at 12:31:35PM +0200, Karel Kulhavy wrote:
> >> I am looking into Documentation/devices.txt in 2.4.25 and eth0 is not listed
> >> there. If I grep "eth", I get only
> >> 
> >> 38 char        Myricom PCI Myrinet board
> >> [...]
> >> "This device is used for status query, board control and "user level
> >> packet I/O."  This board is also accessible as a standard networking
> >> "eth" device.  "
> >> 
> >> and then
> >> 
> >> /dev/pethr0
> >> 
> >> Is eth0 some kind of special device that doesn't have any number
> >> assigned?
> >
> > Yes, there's no such thing as /dev/eth0, network interfaces have their
> > own namespace. Linux uses the defacto standard BSD socket interface for
> > networking, so blame the BSD people for violating the "everything is a
> > file" rule.
> 
> well, the way NIC's behave kind of forbids this
> taken from Linux Device Drivers, 3rd Edition, page 497
> "The normal file operations (read, write, and so on) do not make sense
> when applied to network interfaces, so it is not possible to apply the
> Unix ''everything is a file'' approach to them"   

I think there're other nodes in /dev on which normal file
operations do not make sense either.
-- 
Coywolf
-
