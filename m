Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWDKLLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWDKLLl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWDKLLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:11:41 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:28682 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1750745AbWDKLLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:11:41 -0400
Date: Tue, 11 Apr 2006 13:11:37 +0200
From: Olivier Galibert <galibert@pobox.com>
To: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: What is the most efficient way to copy a bunch of files nowadays?
Message-ID: <20060411111137.GA13961@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Hack inc." <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After having read-only mucked with the headers of a bunch of files[1]
I've selected a subset of 2500 or so with sizes going from 2K to 85M
which I want to copy to another directory in the same local
filesystem.  What is the "best" (CPU usage, fragmentation, wall clock
time, system responsiveness during and after the copy) way to copy
these files?  read+write, mmap+write, read+mmap, mmap+mmap+memcpy,
something else?  That's with recent kernels, of course.

  OG.

[1] Say rpms from a random distribution and its updates for instance
