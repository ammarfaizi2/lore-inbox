Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVCEJvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVCEJvp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 04:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVCEJvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 04:51:45 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55054 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261849AbVCEJvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 04:51:43 -0500
Date: Sat, 5 Mar 2005 09:51:39 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, chrisw@osdl.org
Subject: Re: Linux 2.6.11.1
Message-ID: <20050305095139.A26541@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	chrisw@osdl.org
References: <20050304175302.GA29289@kroah.com> <20050304124431.676fd7cf.akpm@osdl.org> <20050304205842.GA32232@kroah.com> <20050304131537.7039ca10.akpm@osdl.org> <Pine.LNX.4.58.0503041353050.11349@ppc970.osdl.org> <20050304135933.3a325efc.akpm@osdl.org> <20050304220518.GC1201@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050304220518.GC1201@kroah.com>; from greg@kroah.com on Fri, Mar 04, 2005 at 02:05:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 02:05:18PM -0800, Greg KH wrote:
> On Fri, Mar 04, 2005 at 01:59:33PM -0800, Andrew Morton wrote:
> > That tree has the not-for-linus raid6 fix and the not-for-linus i8042 fix.
> 
> Then when the authors of those patches go to submit the fix to Linus,
> they can revert them, or bk can handle the merge properly :)

How about having two BK trees - one containing "fixes for Linus" and
the other "fixes not for Linus but we really need" ?  The "sucker
tree" then becomes the two merged together.

This way, Linus would never see the "fixes not for Linus" at all.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
