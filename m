Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932800AbWCVVht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932800AbWCVVht (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932799AbWCVVht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:37:49 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:3982 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932800AbWCVVhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:37:48 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ashok Raj <ashok.raj@intel.com>
Subject: Re: Linux v2.6.16
Date: Wed, 22 Mar 2006 22:36:20 +0100
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, Peter Williams <pwil3058@bigpond.net.au>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org> <200603222140.00912.rjw@sisk.pl> <20060322130055.A15217@unix-os.sc.intel.com>
In-Reply-To: <20060322130055.A15217@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603222236.21984.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 22:00, Ashok Raj wrote:
> On Wed, Mar 22, 2006 at 09:40:00PM +0100, Rafael J. Wysocki wrote:
> > > 
> > > with that patch, try
> > > 
> > > CONFIG_X86_PC=n
> > > CONFIG_GENERICARCH=y
> > > CONFIG_HOTPLUG_CPU=y
> > 
> > Well, there's nothing like CONFIG_GENERICARCH on x86_64 or I'm obviously
> > missing something. :-)
> > 
> > On x86_64 I can choose between X86_PC and X86_VSMP and I'm not sure I'd like
> > to set X86_VSMP just in order to be able to suspend a box with a dual-core CPU.
> > IMHO that would be over the top.
> > 
> 
> This change is only for i386.. check the patch, its introduced only for arch/i386/Kconfig

Of course you're right, sorry.

> There is no change to x86_64, we anyway choose physflat mode in x86_64 which is exactly 
> same as bigsmp in i386.
> 
> We didnt change anything in x86_64...Why this speculation :(
> 
> Iam attaching that patch for your reference here... in case you lost it and looking at 
> some other patch. :-)
> 
> Could you _please_ really check this and tell me if there is real concern... 

No, there's not.  [Except I think we'll need to document that CONFIG_GENERICARCH
is needed for suspend on i386 SMP machines.]

> its pretty simple patch... no other arch is affected...

OK

Rafael
