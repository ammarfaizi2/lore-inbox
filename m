Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVBOPiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVBOPiA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 10:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbVBOPhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 10:37:43 -0500
Received: from sd291.sivit.org ([194.146.225.122]:42444 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261757AbVBOPhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 10:37:33 -0500
Date: Tue, 15 Feb 2005 16:39:12 +0100
From: Stelian Pop <stelian@popies.net>
To: Len Brown <len.brown@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] [PATCH, new ACPI driver] new sony_acpi driver
Message-ID: <20050215153912.GA3523@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Len Brown <len.brown@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	ACPI Developers <acpi-devel@lists.sourceforge.net>
References: <20050210161809.GK3493@crusoe.alcove-fr> <1108481448.2097.71.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108481448.2097.71.camel@d845pe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 10:30:49AM -0500, Len Brown wrote:

> On Thu, 2005-02-10 at 11:18, Stelian Pop wrote:,
> 
> > 
> > PS: I am also going to submit a bugzilla RFE for the acpi people,
> > I have been told they are more receptive to that.
> 
> I guess that refers to me:-)

Hey, you *are* more receptive to bugzilla then !

> E-mail is fine, but the unfortunate reality is that due to simple
> volume, it is lossy.  The reason we like bugzilla is that it never
> forgets:-)
> 
> So thanks for taking the extra time to file a bug report
> http://bugzilla.kernel.org/show_bug.cgi?id=4193
> 
> If it turns out that there is no way a generic solution
> can handle the SNC Sony laptops, then I agree that a

Note: this is not a subset of the Sony laptops, we are talking
about all the Sony laptops here.

> platform specific wart is the only way to go.  But
> it would be best if we can make the exotic Sony/SNC
> look more generic to the user so that the user
> (and the distro supporting them) don't need to learn
> special things to handle this system.

I agree, but unfortunately I don't think it's possible to handle
them in a generic way. However, my understanding of the ACPI layer
is limited, so I very well be wrong.

I attached two DSDT in bugzilla, I have a few more if you want them.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
