Return-Path: <linux-kernel-owner+w=401wt.eu-S1753593AbWL0IaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbWL0IaT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 03:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbWL0IaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 03:30:18 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:40529
	"EHLO grelber.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593AbWL0IaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 03:30:17 -0500
From: Rob Landley <rob@landley.net>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Subject: Re: Feature request: exec self for NOMMU.
Date: Wed, 27 Dec 2006 03:29:15 -0500
User-Agent: KMail/1.9.1
Cc: ray-gmail@madrabbit.org, linux-kernel@vger.kernel.org,
       David McCullough <david_mccullough@au.securecomputing.com>
References: <200612261823.07927.rob@landley.net> <200612270051.52690.rob@landley.net> <1167199716.5616.3.camel@localhost.localdomain>
In-Reply-To: <1167199716.5616.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612270329.16320.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 December 2006 1:08 am, Vadim Lobanov wrote:
> On Wed, 2006-12-27 at 00:51 -0500, Rob Landley wrote:
> > On Wednesday 27 December 2006 12:13 am, Ray Lee wrote:
> > > How about openning an fd to yourself at the beginning of execution, then
> > > calling fexecve later?
> > 
> > I haven't got a man page for fexecve.  Does libc have it?
> 
> It's implemented inside glibc, and uses /proc to execve() the file that
> the fd points to.

Cute, and I can do that.  Assuming /proc is mounted in the chroot 
environment...

Rob
-- 
"Perfection is reached, not when there is no longer anything to add, but
when there is no longer anything to take away." - Antoine de Saint-Exupery
