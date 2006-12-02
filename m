Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030633AbWLBER1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030633AbWLBER1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 23:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030608AbWLBER1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 23:17:27 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:60295 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030633AbWLBER0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 23:17:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=VRzaAy1wH21N48/W7LRRDLWxMaZ4LMjvMXg8SAd7FsvjNRI3QVp0YTeY9dYYLI9osMA+ciLpaWO//BFd1P9BcWbS7ut04t4uua7Be1He1MUhsZPLQ9ZNI7E+IqW55zhMBR7UuFbOR5H0D1JTV7CSRftHLoF0h2th8pF+kUjBr3g=
Date: Sat, 2 Dec 2006 13:09:49 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Ed Tomlinson <edt@aei.ca>
Cc: Andrew Morton <akpm@osdl.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com, Matt_Domsch@dell.com
Subject: Re: 2.6.19-rc6-mm2
Message-ID: <20061202040949.GB22330@localhost.localdomain>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Ed Tomlinson <edt@aei.ca>, Andrew Morton <akpm@osdl.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	linux-kernel@vger.kernel.org, jgarzik@pobox.com,
	Matt_Domsch@dell.com
References: <20061128020246.47e481eb.akpm@osdl.org> <200612011933.22029.edt@aei.ca> <20061201163248.f174bc0b.akpm@osdl.org> <200612012219.01465.edt@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612012219.01465.edt@aei.ca>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 10:19:00PM -0500, Ed Tomlinson wrote:
> On Friday 01 December 2006 19:32, Andrew Morton wrote:
> > On Fri, 1 Dec 2006 19:33:21 -0500
> > Ed Tomlinson <edt@aei.ca> wrote:
> > 
> > > I booted without the video and vga settings with earlyprintk=vga and got output.  The
> > > kenerl was complaining about a crc error.  Checking the patch list I found:
> > > 
> > > crc32-replace-bitreverse-by-bitrev32.patch
> > > 
> > > reversing this patch fixes booting here.
> > 
> > Odd that you're the only person seeing this - could be a miscompile?
> 
> I recompiled four times.  The only change the last time was to reverse the above patch.  I am using
> gcc is 4.1.1 (gentoo 4.1.1-r1).
>  

Can you try build and boot with that patch again?
I expected there is not any logical changes in that patch. So I want to
make sure it.
