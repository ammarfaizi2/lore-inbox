Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbVLCXJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVLCXJp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 18:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVLCXJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 18:09:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39387 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751294AbVLCXJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 18:09:44 -0500
Date: Sat, 3 Dec 2005 18:09:35 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203230935.GD25015@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>
References: <20051203135608.GJ31395@stusta.de> <20051203205911.GX18919@marowsky-bree.de> <20051203211329.GC25015@redhat.com> <20051203230254.GI25722@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203230254.GI25722@merlin.emma.line.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 12:02:54AM +0100, Matthias Andree wrote:
 > On Sat, 03 Dec 2005, Dave Jones wrote:
 > 
 > > In many cases, submitters of changes know that things are going
 > > to break. Maybe we need a policy that says changes requiring userspace updates
 > > need to be clearly documented in the mails Linus gets (Especially if its
 > > a git pull request), so that when the next point release gets released,
 > > Linus can put a section in the announcement detailing what bits
 > > of userspace are needed to be updated.
 > 
 > This isn't acceptable in stable kernels. FreeBSD has a very tight
 > policy, newer kernels off the same branch support older user space.

The BSDs have an advantage in that their userspace & kernels are closely
coupled. When kernel changes need a userspace change, it gets done at the
same time in the same repository.

		Dave
