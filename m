Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269064AbRHHTz0>; Wed, 8 Aug 2001 15:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269018AbRHHTzQ>; Wed, 8 Aug 2001 15:55:16 -0400
Received: from femail30.sdc1.sfba.home.com ([24.254.60.20]:35005 "EHLO
	femail30.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S268913AbRHHTzB>; Wed, 8 Aug 2001 15:55:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Mike Jadon <mikej@umem.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI NVRAM Memory Card
Date: Wed, 8 Aug 2001 12:54:48 -0700
X-Mailer: KMail [version 1.2]
In-Reply-To: <5.1.0.14.0.20010622101907.03ac21b0@192.168.0.5>
In-Reply-To: <5.1.0.14.0.20010622101907.03ac21b0@192.168.0.5>
MIME-Version: 1.0
Message-Id: <01080812544800.00591@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 August 2001 12:30 pm, Mike Jadon wrote:
> My company has released a PCI NVRAM memory card but we haven't
> developed a Linux driver for it yet.  We want the driver to be open to
> developers to build upon.  Is there a specific path we should follow
> with this being our goal?  In researching Linux driver development I
> have come across "GPL" or "LGPL".  Where do you recommend we go to find
> out more about this development process?
>

The LGPL is primarily ment for libraries so that non-GPL compatible 
products can link to a library (like glibc) without being GPL'd 
themselves, for a linux driver, I'm not sure this would make much sense, 
and licensing might get complex when trying to intigrate it with the 
kernel, I don't know for sure.
you can find a copy of the LGPL here:
http://www.fsf.org/copyleft/lesser.html
as well as reasons to not use it, here
http://www.fsf.org/licenses/why-not-lgpl.html

the GPL-specific FAQ is here:
http://www.fsf.org/licenses/gpl-faq.html
and the GPL itself is avalible here:
http://www.fsf.org/licenses/gpl.html

this is a list of various software Licenses, GPL compatible Free licenses 
are at the top, GPL-incompatible Free licenses are below that
http://www.fsf.org/licenses/license-list.html

> Thanks and my apologies for using a technical forum for this question,
> but wanted to go to the right source.
>
>
> Mike
