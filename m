Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757648AbWLCMw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757648AbWLCMw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 07:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757935AbWLCMwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 07:52:55 -0500
Received: from khepri.openbios.org ([80.190.231.112]:12689 "EHLO
	khepri.openbios.org") by vger.kernel.org with ESMTP
	id S1757648AbWLCMwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 07:52:55 -0500
Date: Sun, 3 Dec 2006 13:52:50 +0100
From: Stefan Reinauer <stepan@coresystems.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Peter Stuge <stuge-linuxbios@cdy.org>, linux-kernel@vger.kernel.org,
       linuxbios@linuxbios.org
Subject: Re: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug device
Message-ID: <20061203125250.GA17019@coresystems.de>
References: <5986589C150B2F49A46483AC44C7BCA490727C@ssvlexmb2.amd.com> <m1irgufl9q.fsf@ebiederm.dsl.xmission.com> <2ea3fae10612021247v33cfaa4evbc8ad1d5eaf196ba@mail.gmail.com> <m1ejrhfb9o.fsf@ebiederm.dsl.xmission.com> <20061203120130.GA32458@coresystems.de> <77E505A2-6E0B-422F-92AB-97395730A522@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77E505A2-6E0B-422F-92AB-97395730A522@kernel.crashing.org>
X-Operating-System: Linux 2.6.18.2-4-default on an x86_64
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Segher Boessenkool <segher@kernel.crashing.org> [061203 13:42]:
> On LPC, yes -- or 0.5us or something like that.  On ISA it's
> a lot faster, on PCI too -- better do 20 or so outb's to be
> safe.

The value's actually something we have been using as a rule of thumb
while doing outb to port 80. Don't think these are routed to LPC, are
they?

-- 
coresystems GmbH • Brahmsstr. 16 • D-79104 Freiburg i. Br.
      Tel.: +49 761 7668825 • Fax: +49 761 7664613
Email: info@coresystems.de  • http://www.coresystems.de/
