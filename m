Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVHAHN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVHAHN2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 03:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVHAHN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 03:13:28 -0400
Received: from ozlabs.org ([203.10.76.45]:59619 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262403AbVHAHL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 03:11:28 -0400
Date: Mon, 1 Aug 2005 17:10:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Olaf Hering <olh@suse.de>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Remove another fixed address constraint
Message-ID: <20050801071050.GE13052@localhost.localdomain>
Mail-Followup-To: Olaf Hering <olh@suse.de>,
	Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
References: <20050725061635.GD19817@localhost.localdomain> <20050801062929.GA22102@suse.de> <20050801063554.GC13052@localhost.localdomain> <20050801064502.GB22175@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801064502.GB22175@suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 08:45:02AM +0200, Olaf Hering wrote:
>  On Mon, Aug 01, David Gibson wrote:
> 
> > Hrm.. definitely works here.  Is this with any other patches?  Can you
> > send the .s file?  That might help be debug it.
> 
> It works with SLES9 gcc3, only gcc4 (or recent binutils) do not like
> it.

gcc4 can't be the problem; that's an assembler error.  I am using:

sneetch:~/kernel$ powerpc64-linux-as --version
GNU assembler 2.15.94 20041116
Copyright 2002 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms
of
the GNU General Public License.  This program has absolutely no
warranty.
This assembler was configured for a target of `powerpc-linux'.


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
