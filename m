Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263025AbREWJYr>; Wed, 23 May 2001 05:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263026AbREWJYh>; Wed, 23 May 2001 05:24:37 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:2757 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S263025AbREWJYb>; Wed, 23 May 2001 05:24:31 -0400
Message-ID: <3B0B81C6.14770A10@TeraPort.de>
Date: Wed, 23 May 2001 11:24:22 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Output of L1,L2 and L3 cache sizes to /proc/cpuinfo
In-Reply-To: <Pine.LNX.4.30.0105230307470.4030-100000@Appserv.suse.de>
Content-Type: multipart/mixed;
 boundary="------------D205068CA1E0CAE4E50CE275"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D205068CA1E0CAE4E50CE275
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dave Jones wrote:
> 
> On Wed, 23 May 2001, Tomas Telensky wrote:
> 
> > Yes. Recently I tried to transform whole cpuid code to a userspace
> > utility. Not easy, not clean... but it worked.
> 
> See http://www.sourceforge.net/projects/x86info
> or ftp://ftp.suse.com/pub/people/davej/x86info/
> 

 thanks for the pointer. Definitely gives some very interesting
information about ones x86 CPU. At least something to work on. The
output for different CPU types is a bit incoherent, making it difficult
to parse. That why I [still] think (yes I'm stubborn :-) that having the
cache sizes in /proc/cpuinfo in one format is a good idea. The info is
there, it is just the output. With the userland tool, you always may
have discrepancies between the kernels view and the tools view.

 But I agree, it does not *have* to go into the kernel.

Cheers
MArtin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
--------------D205068CA1E0CAE4E50CE275
Content-Type: text/x-vcard; charset=us-ascii;
 name="Martin.Knoblauch.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Martin.Knoblauch
Content-Disposition: attachment;
 filename="Martin.Knoblauch.vcf"

begin:vcard 
n:Knoblauch;Martin
tel;cell:+49-170-4904759
tel;fax:+49-89-510857-111
tel;work:+49-89-510857-309
x-mozilla-html:FALSE
url:http://www.teraport.de
org:TeraPort GmbH;C+ITS
adr:;;Garmischer Straße 4;München;Bayern;D-80339;Germany
version:2.1
email;internet:Martin.Knoblauch@TeraPort.de
title:Senior System Engineer
x-mozilla-cpt:;-7008
fn:Martin Knoblauch
end:vcard

--------------D205068CA1E0CAE4E50CE275--

