Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVBKTPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVBKTPw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 14:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVBKTLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 14:11:07 -0500
Received: from codepoet.org ([166.70.99.138]:23975 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S262300AbVBKTHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 14:07:36 -0500
Date: Fri, 11 Feb 2005 12:01:54 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Greg KH <gregkh@suse.de>
Cc: Christian Borntr?ger <christian@borntraeger.net>,
       Bill Nottingham <notting@redhat.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Message-ID: <20050211190153.GA8110@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org, Greg KH <gregkh@suse.de>,
	Christian Borntr?ger <christian@borntraeger.net>,
	Bill Nottingham <notting@redhat.com>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050211004033.GA26624@suse.de> <20050211031823.GE29375@nostromo.devel.redhat.com> <1108104417.32129.7.camel@localhost.localdomain> <200502111719.23163.christian@borntraeger.net> <20050211170144.GA16074@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211170144.GA16074@suse.de>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Feb 11, 2005 at 09:01:44AM -0800, Greg KH wrote:
> It's not only pci, but all types of busses need this kind of "coldplug"
> functionality.  And yes, I have plans to provide that functionality in
> this package too.
> 
> In fact, if anyone looking to contribute some well defined and easy to
> test code... :)

The pcimodules patch to pciutils does this sortof coldplug device
scanning for pci devices:
http://www.linuxfromscratch.org/patches/downloads/pciutils/pciutils-2.1.11-pcimodules-1.patch

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
