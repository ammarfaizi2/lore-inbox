Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVI2HWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVI2HWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 03:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbVI2HWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 03:22:42 -0400
Received: from web51008.mail.yahoo.com ([206.190.38.139]:7840 "HELO
	web51008.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932141AbVI2HWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 03:22:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=DTBN6U2FnjnvS8TZmwIZMhpHu+gbxi3LnskwVoBNfaiCy3kbP2LtoLcxwvYcCijPNyHHhm5hg5sHgnu7rr/0OdNtr5tGXfRu7nVmGKz+uWyPn01tYlAAZ/WS2uvyk3yygn5zQMmMGL0iyznp+8xsr/mqoctNwCGG358RI9bR9tI=  ;
Message-ID: <20050929072240.74436.qmail@web51008.mail.yahoo.com>
Date: Thu, 29 Sep 2005 00:22:40 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: Re: [ANNOUNCE] Framework for automatic Configuration of a Kernel
To: Emmanuel Fleury <fleury@cs.aau.dk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <433A81F0.2080409@cs.aau.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Emmanuel Fleury <fleury@cs.aau.dk> wrote:

> > I think its good to detect everything, that let a
> > Kernel work after the installation. I mean it the
> > autoconfiguration should't be only for
> Kernel-Hackers.
> > Maybe its good idea to make two type of detection
> > 
> > 1. which detects only the HW(For Kernel-Hackers)
> > 2. which detects all the HW and configure
> everything
> > that let the Kernel work.(for beginners)
> 
> Why would a beginner compile a kernel ?

Because he wants to be upto date
 
> I would even say this would be bad if you can avoid
> them to go through
> all the documentations of each option. :)

Why? 

> > The best was is to use HW-Detection-Tools that are
> in
> > naked Kernel. But I dont know if is lspci is in
> the
> > Kernel. I mean dmidecode is good for detecting all
> the
> > HW but it has to be installed first. And its no
> good
> > to let the user install first of all some tools so
> the
> > autoconfigure can work.
> > How do we get the HW detected from a naked Kernel
> > without any Distrubotion or whatever.   
> 
> I doubt we can, at least not in the current status.
> 
> And requiring more external tools as lspci,
> dmidecode, etc, is probably
> not right.
> 
> More I am thinking of it, more it seems that the
> hardware detection
> softwares (lspci, dmidecode, lsusb) should be
> stripped down and probably
> included somewhere in the kernel tree... But
> wouldn't be too much to pay
> for having an autoconfig ? (I mean maintenance,
> update, debug, ... will
> be way out of the scope of the kernel).

How about making a new project for calling all the
Hardware on the system directly from the I/O and let
then be a part of the Kernel? Its just a suggestion!!

> Did anybody had some though about this previously (I
> tried to look in
> the archive of the LKM but didn't find anything
> relevant) ?
> 
> > I dont understand your question. What you mean
> with
> > interfaces??
> 
> ncurses, Qt, Gtk, ... (aka menuconfig, xconfig,
> gconfig).

Why should it be in other interfaces?? The plan of the
autoconfig is just to configure the Kernel and nothing
more... What is the advantage of having it in other
interfaces?? 

Regards 
Ahmad Reza Cheraghi


		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
