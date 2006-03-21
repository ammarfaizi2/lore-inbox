Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWCUAFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWCUAFg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 19:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWCUAFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 19:05:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57569 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751354AbWCUAFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 19:05:35 -0500
Date: Mon, 20 Mar 2006 19:05:16 -0500
From: Dave Jones <davej@redhat.com>
To: Olivier Galibert <galibert@pobox.com>, Greg KH <gregkh@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.16
Message-ID: <20060321000516.GA3411@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Olivier Galibert <galibert@pobox.com>, Greg KH <gregkh@suse.de>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060320212338.GA11571@kroah.com> <20060320235846.GA84147@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320235846.GA84147@dspnet.fr.eu.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 12:58:46AM +0100, Olivier Galibert wrote:
 > On Mon, Mar 20, 2006 at 01:23:38PM -0800, Greg KH wrote:
 > > They are the same "delete devfs" patches that I submitted for 2.6.12 and
 > > 2.6.13 and 2.6.14 and 2.6.15.  It rips out all of devfs from the kernel
 > > and ends up saving a lot of space.  Since 2.6.13 came out, I have seen
 > > no complaints about the fact that devfs was not able to be enabled
 > > anymore, and in fact, a lot of different subsystems have already been
 > > deleting devfs support for a while now, with apparently no complaints
 > > (due to the lack of users.)
 > 
 > Devfs for block devices is required for the fedora core 3 install
 > kernel.  I haven't checked whether fc4 needs it too (DaveJ?)

Hell no. It's never been included in any Fedora release.
Make it dead already.

		Dave

-- 
http://www.codemonkey.org.uk
