Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263398AbRFAH1f>; Fri, 1 Jun 2001 03:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263399AbRFAH1Z>; Fri, 1 Jun 2001 03:27:25 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:10650 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263398AbRFAH1S>;
	Fri, 1 Jun 2001 03:27:18 -0400
Message-ID: <3B1743CE.EE3F7CD2@mandrakesoft.com>
Date: Fri, 01 Jun 2001 03:27:10 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for real 
 this  time)
In-Reply-To: <200106010657.f516vmx11933@www.hockin.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Off-hand I see old style initialization. Is it right for new driver?
> 
> the old-style init is because it is an old driver.  I want to do a full-on
> rework, but haven't had the time.

New-style init by itself shouldn't be hard to do, independent of a full
re-work...


> > 2. Spaces and tabs are mixed in funny ways, makes to cute effects
> > when quoting diffs.
> 
> I've tried to eliminate that when I see it - I'll give the diff a close
> examination.

Why not just run indent over the source before submitting.  That will
regularize this stuff, and ensure that you are close to
Documentation/CodingStyle.

Here is the command I use.  The first two options are the only really
importants ones...

indent -kr -i8 -npsl -pcs -l100 -lc120

(line length is 100 because line length 72/75/80 winds up wrapping long
printk and logic lines when typically the programmer didn't want them to
be wrapped)

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
