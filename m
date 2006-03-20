Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWCTX64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWCTX64 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 18:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWCTX6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 18:58:55 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:2825 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751338AbWCTX6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 18:58:54 -0500
Date: Tue, 21 Mar 2006 00:58:46 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [GIT PATCH] Remove devfs from 2.6.16
Message-ID: <20060320235846.GA84147@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	davej@redhat.com
References: <20060320212338.GA11571@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320212338.GA11571@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 01:23:38PM -0800, Greg KH wrote:
> They are the same "delete devfs" patches that I submitted for 2.6.12 and
> 2.6.13 and 2.6.14 and 2.6.15.  It rips out all of devfs from the kernel
> and ends up saving a lot of space.  Since 2.6.13 came out, I have seen
> no complaints about the fact that devfs was not able to be enabled
> anymore, and in fact, a lot of different subsystems have already been
> deleting devfs support for a while now, with apparently no complaints
> (due to the lack of users.)

I'm an occasional user.  I'm just able to add a config entry by hand.

Devfs for block devices is required for the fedora core 3 install
kernel.  I haven't checked whether fc4 needs it too (DaveJ?), but if
it is the case it would be a real bad idea to remove it before fc6 is
out.

I know, I know, compatibility is for the weak.

  OG.

