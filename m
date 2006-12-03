Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935871AbWLCMBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935871AbWLCMBd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 07:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936696AbWLCMBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 07:01:33 -0500
Received: from khepri.openbios.org ([80.190.231.112]:35756 "EHLO
	khepri.openbios.org") by vger.kernel.org with ESMTP id S935871AbWLCMBd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 07:01:33 -0500
Date: Sun, 3 Dec 2006 13:01:30 +0100
From: Stefan Reinauer <stepan@coresystems.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: yhlu <yinghailu@gmail.com>, Peter Stuge <stuge-linuxbios@cdy.org>,
       linux-kernel@vger.kernel.org, linuxbios@linuxbios.org
Subject: Re: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug device
Message-ID: <20061203120130.GA32458@coresystems.de>
References: <5986589C150B2F49A46483AC44C7BCA490727C@ssvlexmb2.amd.com> <m1irgufl9q.fsf@ebiederm.dsl.xmission.com> <2ea3fae10612021247v33cfaa4evbc8ad1d5eaf196ba@mail.gmail.com> <m1ejrhfb9o.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m1ejrhfb9o.fsf@ebiederm.dsl.xmission.com>
X-Operating-System: Linux 2.6.18.2-4-default on an x86_64
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Eric W. Biederman <ebiederm@xmission.com> [061203 12:51]:
> > BTW in kernel earlyprintk or prink, you could use
> > read_pci_config/write_pci_config before PCI system is loaded.
> 
> Yep thanks that seems to be working.  Now I just need
> to find an early delay and I can try this mess out!

you could use io delay, one outb uses roughly 1us iirc.

-- 
coresystems GmbH • Brahmsstr. 16 • D-79104 Freiburg i. Br.
      Tel.: +49 761 7668825 • Fax: +49 761 7664613
Email: info@coresystems.de  • http://www.coresystems.de/
