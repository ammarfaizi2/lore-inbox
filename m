Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293658AbSCPBvL>; Fri, 15 Mar 2002 20:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293657AbSCPBvB>; Fri, 15 Mar 2002 20:51:01 -0500
Received: from pcls2.std.com ([199.172.62.104]:38873 "EHLO TheWorld.com")
	by vger.kernel.org with ESMTP id <S293656AbSCPBup>;
	Fri, 15 Mar 2002 20:50:45 -0500
Message-ID: <3C92A4EB.C50ED834@world.std.com>
Date: Fri, 15 Mar 2002 20:50:35 -0500
From: Gordon J Lee <gordonl@world.std.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.18-m1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: IBM x360 2.2.x boot failure, 2.4.9 works fine
In-Reply-To: <3C927F3E.7C7FB075@world.std.com> <20020315233441.GG5563@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------D43B7AEA21899E923F578BC1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D43B7AEA21899E923F578BC1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Thanks for the rapid replies,


> Eeek, these machines are now in the wild?  Didn't realize this :)

Yes.  They are still ramping up production, and evals are scarce.
I am pretty excited about it, because on paper, even without
the hyperthreading, they should run pretty fast for I/O intensive
workloads.  My current eval project is to get some empirical
performance numbers on a particular application.

> I don't know if anyone ever tried a 2.2.x kernel on these boxes :)

I'm first!  Lucky me!   :-)


> Is there a reason you _really_ need a 2.2.x kernel for this machine?

Longterm no, shortterm yes,
We have some modifications to the 2.2.x kernel/drivers that would cost
us some time to migrate to 2.4.x.  We expect to do this, but not within
the short eval period during which I have the box.  My immediate goal
is to get it running enough to take performance measurements so we
can clearly quantify the cost/benefit of migrating to this box.


> You also might try a UP 2.2.x kernel on this box to see if the problem
> is in the parsing of the APIC tables (as I think it is.)

As a matter of fact, we did try a UP 2.2.x kernel, and it worked.  But then

we only have one CPU, and where is the fun in that ?  :-)
So I suppose this gives further support to the mishandled APIC table
theory.

I am interested and motivated to understand the details of APIC's further.
If I were to attempt to patch up a 2.2.x kernel to workaround this problem,

what documentation should I have on hand ?  I have an Intel SMP 1.4
doc, although I haven't studied it in detail yet.  Is this sufficient or
are
there other Must Have documents that I will need ?

    - GL


--------------D43B7AEA21899E923F578BC1
Content-Type: text/x-vcard; charset=us-ascii;
 name="gordonl.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Gordon J Lee
Content-Disposition: attachment;
 filename="gordonl.vcf"

begin:vcard 
n:Lee;Gordon
tel;fax:(617) 354-9272
tel;home:(617) 576-1779
tel;work:(617) 354-9292 x108
x-mozilla-html:TRUE
url:http://www.mazunetworks.com
org:Mazu Networks
adr:;;50 Cushing Street;Cambridge;MA;02138;USA
version:2.1
email;internet:gordonl@world.std.com
title:Principal Software Engineer
note;quoted-printable:125 Cambridge Park Drive=0D=0ACambridge, MA  02140=0D=0A=0D=0A
x-mozilla-cpt:;0
fn:Gordon Lee
end:vcard

--------------D43B7AEA21899E923F578BC1--

