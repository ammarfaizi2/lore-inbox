Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbVIIHtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbVIIHtE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 03:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbVIIHtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 03:49:04 -0400
Received: from web51014.mail.yahoo.com ([206.190.39.79]:16217 "HELO
	web51014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751433AbVIIHtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 03:49:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=x0w+W/oe0isaty8efsUZ1RNb4qC6lcH/h3aMLCJtD0vK2EWG+gMHNIaYP5ZMEgVcvAbvmQYd1oefNpyFkaSkB+Sg+gaRWrci9X/xVfPOkpUG88QGylghCLrfpXwZf7fgZ+lOZhcUwT6AdRyrDRVl20LDer10RFyezCtOy1py33M=  ;
Message-ID: <20050909074900.62012.qmail@web51014.mail.yahoo.com>
Date: Fri, 9 Sep 2005 00:48:59 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Re: Automatic .config generation
To: linux-kernel@vger.kernel.org
Cc: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b05090814132ebe54dd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Alex Riesen <raa.lkml@gmail.com> wrote:

> On 9/8/05, Ahmad Reza Cheraghi
> <a_r_cheraghi@yahoo.com> wrote:
> > I made this Framework to generate a .config based
> on a
> > Target-System. Right-now it works on my Laptop
> Acer
> 
> how about teaching it to generate .config using just
> sysfs and lsbus?

Thats another way, to find the Hardware(better than
dmesg). But is this always installed on a nacked
Kernel? And i think, lsbus is not supported by the new
sysfsutils. 
The best thing is for detecting the Hardware is
directly from the I/O, and the only program I know is
lspci.
 
> So noone will need to contact you regarding adding
> their system to
> your files, especially when all the information is
> already present in
> the kernel in a very parsable form (pci.ids, for
> example).
Thangs, didn't know that!
 
> The whole scenary will then shorten to:
> $ make autoconfig
> $ make
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



	
		
______________________________________________________
Click here to donate to the Hurricane Katrina relief effort.
http://store.yahoo.com/redcross-donate3/
