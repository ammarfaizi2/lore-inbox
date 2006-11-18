Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752929AbWKRAe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbWKRAe0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756079AbWKRAe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:34:26 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:14277 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752929AbWKRAe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:34:26 -0500
Date: Fri, 17 Nov 2006 19:33:52 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, rjw@sisk.pl
Subject: Re: [PATCH 9/20] x86_64: 64bit PIC SMP trampoline
Message-ID: <20061118003352.GA4321@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061117223432.GA15449@in.ibm.com> <20061117224535.GJ15449@in.ibm.com> <20061118002710.GF9188@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061118002710.GF9188@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2006 at 01:27:10AM +0100, Pavel Machek wrote:
> Hi!
> 
> > that long mode is supported.  Asking if long mode is implemented is
> > down right silly but we have traditionally had some of these checks,
> > and they can't hurt anything.  So when the totally ludicrous happens
> > we just might handle it correctly.
> 
> Well, it is silly, and it is 50 lines of dense assembly. can we get
> rid of it or get it shared with bootup version?
> 

Hi Pavel,

Last patch in the series (patch 20)  already does that. That patch just
puts all the assembly at one place which everybody shares. 

I know it is bad to introduce and delete your own code, but I kept that
patch as last patch as all the other patches have got fair bit of testing
in RHEL kernels and I wanted to make sure that if last patch breaks something
problem can be isolated relatively easily.

Thanks
Vivek
