Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265259AbUBIQol (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 11:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbUBIQok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 11:44:40 -0500
Received: from dsl-082-083-132-139.arcor-ip.net ([82.83.132.139]:14472 "EHLO
	server1.intern.kubla.de") by vger.kernel.org with ESMTP
	id S265259AbUBIQoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 11:44:38 -0500
Date: Mon, 9 Feb 2004 17:44:24 +0100
From: Dominik Kubla <dominik@kubla.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.3-rc1-mm1
Message-ID: <20040209164424.GA1795@intern.kubla.de>
References: <20040209014035.251b26d1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040209014035.251b26d1.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 01:40:35AM -0800, Andrew Morton wrote:
> 
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc1/2.6.3-rc1-mm1/
> 
> 
> - NFSD update

How about including the NFSACL patch from acl.bestbits.at? One reason
for people to move to 2.6 from 2.4 is that they no longer need to patch
the kernel to get ACL support. Unless they want to have ACL support over
NFSv3 that is... NFSACL support is quite an argument for Linux in an existing
Solaris production environments, so i would like to see it included
into the mainstream kernel ASAP (Note: I am not speaking for Andreas and
the other people working on the ACL code!). Including it into -mm would give
it the necessary exposure.

The patch is available in broken up form at:
  http://acl.bestbits.at/current/diff/nfsacl-2.6.1-0.8.67.tar.gz

And before somebody mentions NFSv4: This is not (yet) an option for production
environments.

Regards,
  Dominik Kubla
-- 
L'hazard ne favorise que l'esprit prepare.  
		-- L. Pasteur
