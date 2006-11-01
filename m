Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992614AbWKAPbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992614AbWKAPbE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 10:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992621AbWKAPbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 10:31:04 -0500
Received: from holoclan.de ([62.75.158.126]:17614 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S2992614AbWKAPbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 10:31:01 -0500
Date: Wed, 1 Nov 2006 16:27:46 +0100
From: Martin Lorenz <martin@lorenz.eu.org>
To: Andi Kleen <ak@suse.de>
Cc: Jan Beulich <jbeulich@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc3: more DWARFs and strange messages
Message-ID: <20061101152746.GD6438@gimli>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Jan Beulich <jbeulich@novell.com>, linux-kernel@vger.kernel.org
References: <20061028200151.GC5619@gimli> <20061031160815.GM27390@gimli> <454787AB.76E4.0078.0@novell.com> <200610311828.52980.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610311828.52980.ak@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Tue, Oct 31, 2006 at 06:28:52PM +0100, Andi Kleen
	wrote: > On Tuesday 31 October 2006 17:28, Jan Beulich wrote: > > Can
	you perhaps get us arch/i386/kernel/{entry,process}.o, > > .config, and
	(assuming you can reproduce the original problem) > > the raw stack dump
	obtained with a sufficiently high kstack= > > option? > > WARN_ON
	unfortunately doesn't dump the raw stack at all (maybe that > should be
	fixed) [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 06:28:52PM +0100, Andi Kleen wrote:
> On Tuesday 31 October 2006 17:28, Jan Beulich wrote:
> > Can you perhaps get us arch/i386/kernel/{entry,process}.o,
> > .config, and (assuming you can reproduce the original problem)
> > the raw stack dump obtained with a sufficiently high kstack=
> > option?
> 
> WARN_ON unfortunately doesn't dump the raw stack at all (maybe that
> should be fixed) 

what is a reasonable kstack parameter to be informative for you?

> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107
