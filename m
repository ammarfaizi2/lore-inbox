Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVCWOEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVCWOEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 09:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVCWOEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 09:04:15 -0500
Received: from smtp-out.tiscali.no ([213.142.64.144]:62982 "EHLO
	smtp-out.tiscali.no") by vger.kernel.org with ESMTP id S262399AbVCWOD7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 09:03:59 -0500
Subject: Re: forkbombing Linux distributions
From: Natanael Copa <mlists@tanael.org>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: aq <aquynh@gmail.com>, "Hikaru1@verizon.net" <Hikaru1@verizon.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050323134525.GA5374@harddisk-recovery.com>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
	 <20050322112628.GA18256@roll>
	 <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
	 <20050322124812.GB18256@roll> <20050322125025.GA9038@roll>
	 <9cde8bff050323025663637241@mail.gmail.com> <1111581459.27969.36.camel@nc>
	 <20050323134525.GA5374@harddisk-recovery.com>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 15:03:56 +0100
Message-Id: <1111586636.27969.81.camel@nc>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 14:45 +0100, Erik Mouw wrote:
> On Wed, Mar 23, 2005 at 01:37:38PM +0100, Natanael Copa wrote:
> > On Wed, 2005-03-23 at 19:56 +0900, aq wrote:
> > > > /etc/limits does a better job at stopping forkbombs.
> > 
> > but does not limit processes that are started from the boot scripts. So
> > if a buggy non-root service is exploited, an attacker would be able to
> > easily shut down the system.
> 
> That's easy to fix: set limits from initrd or initramfs.

..or run "ulimit -u" early in the boot scripts.

What I suggest is doing the reverse. Let the kernel be restrictive by
default and let distro's or sysadmins open up if they need more
processes.

--
Natanael Copa


