Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270419AbUJUG0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270419AbUJUG0Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270413AbUJTT1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:27:53 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:2315 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S270336AbUJTTXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:23:19 -0400
Message-ID: <4176BDDA.1020406@techsource.com>
Date: Wed, 20 Oct 2004 15:34:50 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: vonbrand@inf.utfsm.cl, jgarzik@pobox.com, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, jeremy@sgi.com
Subject: Re: [DOC] Linux kernel patch submission format
References: <200409221947.i8MJlnSX003715@laptop11.inf.utfsm.cl>	<41543786.5090107@techsource.com> <20040924082241.6bb1c849.rddunlap@osdl.org>
In-Reply-To: <20040924082241.6bb1c849.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Randy.Dunlap wrote:
> On Fri, 24 Sep 2004 11:04:38 -0400 Timothy Miller wrote:
> 
> | 
> | 
> | Horst von Brand wrote:
> | > Timothy Miller <miller@techsource.com> said:
> | > 
> | >>Does the Linux kernel source tree include a shell script which will 
> | >>compare two trees, create patches, and ask the necessary questions so as 
> | >>to format the files correctly with all the right stuff?
> | > 
> | > 
> | > diff(1) does what you want...
> | 
> | So, in addition to producing the difference, diff also asks you all the 
> | questions necessary for a Linux kernel submission, properly formats 
> | them, and adds them to the diff output?
> 
> Of course not.  There is no script in the kernel tree that does
> what you asked... but you probably knew that.
> 
> Is one really needed?  or maybe a GUI IDE is all that is required.

Yes, it's needed.

Rather than having a strict policy which many people are going to 
violate because they don't understand all the intricacies, it would be 
beneficial to have a script that everyone uses which enforces all the rules.

Among other things, this reduces confusion and the barrier to entry.

More patches will be acceptable, and no one will ever have to clean up a 
patch which is really important but just not formatted quite right.

Hey, think about it.  We're computer geeks who should understand very 
well how computers can be used as tools to automate processes, taking 
the burden off of humans.  Given that dozens of patches are posted every 
day, this seems like a prime candidate for automation!

Furthermore, the script can be written to do interesting and helpful 
things that no one would consider putting into the policy because they 
would be too bothersome for the user to do.

If I knew bash, perl, python, or any other scripting language, I would 
volunteer.  I don't think you'd like my horribly non-portable C or C++ 
version, and I don't think Verilog, PHP, or Javascript would quite do 
the job either.  :)

