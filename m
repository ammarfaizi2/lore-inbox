Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbWANGyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWANGyX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 01:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbWANGyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 01:54:23 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:14489 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751528AbWANGyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 01:54:22 -0500
Date: Fri, 13 Jan 2006 22:54:10 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Lee Revell <rlrevell@joe-job.com>
cc: Steven Rostedt <rostedt@goodmis.org>, Roger Heflin <rheflin@atipa.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Dual core Athlons and unsynced TSCs
In-Reply-To: <1137178506.15108.38.camel@mindpipe>
Message-ID: <Pine.LNX.4.62.0601132253490.8795@schroedinger.engr.sgi.com>
References: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com> 
 <1137168254.7241.32.camel@localhost.localdomain>  <1137174463.15108.4.camel@mindpipe>
  <Pine.LNX.4.58.0601131252300.8806@gandalf.stny.rr.com> 
 <1137174848.15108.11.camel@mindpipe>  <Pine.LNX.4.58.0601131338370.6971@gandalf.stny.rr.com>
 <1137178506.15108.38.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2006, Lee Revell wrote:

> I want to know if clock_gettime(CLOCK_MONOTONIC, *ts) is actually
> guaranteed to be monotonic on these machines AKA do we break POSIX
> compliance or not.

Yes you do. Other arches have had the same issues.... See IA64 code.

