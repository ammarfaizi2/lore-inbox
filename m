Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWCVNZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWCVNZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 08:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWCVNZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 08:25:10 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:54505 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751221AbWCVNZJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 08:25:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G3MLYCLXo67wKYfdTzsvsBZcBLgtRQ/qO764G6BW4A2Fyz+lBLWpoC4h/I9dC1SP/iwcBzWF+eCScaeLfEIS5RLVj1KE2/eAtELkl60F01OuPO9fc2AW97v1wC6w8svx8nMm3MP7bQn/ajcmj1ca5AgxzumCuo/w0B2OFGZxVKQ=
Message-ID: <6bffcb0e0603220525o1b573e44t@mail.gmail.com>
Date: Wed, 22 Mar 2006 14:25:08 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ashok Raj" <ashok.raj@intel.com>
Subject: Re: Linux v2.6.16
Cc: akpm@osdl.org, "Peter Williams" <pwil3058@bigpond.net.au>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060322050837.A9452@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org>
	 <4420DF21.8060700@bigpond.net.au>
	 <20060321223120.A4003@unix-os.sc.intel.com>
	 <20060322050837.A9452@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/03/06, Ashok Raj <ashok.raj@intel.com> wrote:
> On Tue, Mar 21, 2006 at 10:31:20PM -0800, Ashok Raj wrote:
> > On Tue, Mar 21, 2006 at 09:22:41PM -0800, Peter Williams wrote:
> > >
> > >    I/O APICs
> > >    Mar 22 16:10:31 heathwren kernel: More than 8 CPUs detected and
> > >    CONFIG_X86_PC cannot handle it.
> > >
> > >    ###  No more CPUs seen but something in there thinks there's more than
> > >    8
> > >    of them.
> > >
> > >    Mar 22 16:10:31 heathwren kernel: Use CONFIG_X86_GENERICARCH or
> > >    CONFIG_X86_BIGSMP.
> > >
> >
> >
>
> Hi Andrew
>
> Please consider for inclusion... resending with changelog per Andrew.
>

SOFTWARE_SUSPEND depends on HOTPLUG_CPU.

It maybe useful for modern laptops, dual core desktops etc.

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
