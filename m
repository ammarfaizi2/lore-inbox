Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265896AbUFISVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265896AbUFISVM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 14:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUFISVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 14:21:12 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:42420 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265896AbUFISVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 14:21:10 -0400
Date: Wed, 9 Jun 2004 19:20:37 +0100
From: Dave Jones <davej@redhat.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Chris Mason <mason@suse.com>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in reiserfs
Message-ID: <20040609182037.GA12771@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Hans Reiser <reiser@namesys.com>, Chris Mason <mason@suse.com>,
	=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
References: <20040609122226.GE21168@wohnheim.fh-wedel.de> <1086784264.10973.236.camel@watt.suse.com> <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com> <1086801345.10973.263.camel@watt.suse.com> <40C75141.7070408@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C75141.7070408@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 11:04:49AM -0700, Hans Reiser wrote:
 > >>Can you give me some background on whether this is causing real problems 
 > >>for real users?
 > >
 > >Especially with the 4k stack option enabled, it will cause real problems
 > >for real users.  A better change would be to cut down on the size of the
 > >tree balance struct, but that would be more invasive.  For starters we
 > >might be able to switch from ints to shorts for some of the arrays.
 > >
 > >-chris
 > >
 > Can you tell me about the "4k stack option"?

Arjan's original patch & announcement are at
http://people.redhat.com/arjanv/4kstack.patch

		Dave

