Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUIDSA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUIDSA1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 14:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUIDSA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 14:00:27 -0400
Received: from the-village.bc.nu ([81.2.110.252]:58008 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265211AbUIDR7D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 13:59:03 -0400
Subject: Re: [Umbrella-devel] Re: Getting full path from dentry in LSM hooks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kristian =?ISO-8859-1?Q?S=F8rensen?= <ks@cs.aau.dk>
Cc: umbrella-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4138CE6F.10501@cs.aau.dk>
References: <41385FA5.806@cs.aau.dk>
	 <1094220870.7975.19.camel@localhost.localdomain> <4138CE6F.10501@cs.aau.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1094317006.10555.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 04 Sep 2004 17:56:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-03 at 21:05, Kristian Sørensen wrote:
> If an email client receives an malformed email (like the countless 
> attacks on outlook), a simple restriction could be for the process 
> handeling the mail would be "$HOME/.addressbook", furthermore, you could 
> specify that attachments executed _from_ the emailprogram would not have 
> access to the network. Thus the virus cannot find mail addresses to send 
> itself to - and it cannot even get network access. Simple and effective.

ln /tmp/bwhahaha $HOME/.addressbook
more /tmp/bwhahaha

As the nice man from the NSA said ;) label content not paths. Use xattrs
to say "this is an addressbook" and then the path games go away.

