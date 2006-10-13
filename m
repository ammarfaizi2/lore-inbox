Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751868AbWJMUWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbWJMUWZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 16:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbWJMUWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 16:22:25 -0400
Received: from web83115.mail.mud.yahoo.com ([216.252.101.44]:2923 "HELO
	web83115.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751868AbWJMUWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 16:22:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=SjKKeOWjYPijVgM/4wwUgIHbgIbuVplGgwhrfjLCYkmYlKijsnHq/7Us4ek/6AnPz8L/q+G3wRT6s2Yjhxud/3nLnOlDkGZcspLXD8KYgfolPVTwvPWXaWWCgrE7Xksne8Sen5p9dO2Wyow5sctXZ5S0z3cWYBAh/3t0BO1kDSg=  ;
Message-ID: <20061013202224.95503.qmail@web83115.mail.mud.yahoo.com>
Date: Fri, 13 Oct 2006 13:22:24 -0700 (PDT)
From: Aleksey Gorelov <dared1st@yahoo.com>
Subject: Re: Machine reboot
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>,
       Auke Kok <auke-jan.h.kok@intel.com>
Cc: Aleksey Gorelov <dared1st@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061013162210.GG3039@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:

> On Fri, Oct 13, 2006 at 07:36:01AM -0700, Auke Kok wrote:
> > >It's not an issue in the Linux kernel. Using various printk I can see that
> > >tripple fault or reset via KBD is issued and followed by hang of the BIOS. 
> > >
> > >For i965 chipsets, the BIOS is *a lot* buggy :(
> > 
> > that's depressing, can you send me the output of `dmidecode` of the latest 
> > BIOS? Perhaps I can reproduce it myself with that version.
> 
> Good news, as of kernel 2.6.19-rc1-git9, BIOS does *not* hang with both e1000 as
> module or built in kernel.
> 
> The previous version of kernel was 2.6.18 which hangs the BIOS.
> 
> Aleksey:
> are you sure that it is not the same in your case? Did you not switch kernel
> version between e1000 as a module and built in kernel?

  As far as I understand, you've udpated the whole kernel, not just the driver. I've tried using
driver from 2.6.19-rc2 as well as v7.2.9 from Intel's website - same story - still no reboot. Did
you try just updating driver (without whole kernel) ? 

Aleks.


