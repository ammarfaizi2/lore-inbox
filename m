Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTDJBdC (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 21:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263981AbTDJBdC (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 21:33:02 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:16591 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263980AbTDJBdB (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 21:33:01 -0400
Date: Thu, 10 Apr 2003 02:44:17 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: 2.5->2.4 nfs corrupts
Message-ID: <20030410014417.GA3197@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org,
	neilb@cse.unsw.edu.au
References: <20030410013349.GC467@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030410013349.GC467@zip.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 10, 2003 at 11:33:49AM +1000, CaT wrote:
 > nfs server: 2.4.21-pre2
 > nfs client: 2.5.67

Quite a few people (myself included) are seeing this.
>From the reports I've seen so far, it looks like it only
happens when the client is a faster box than the server.
In my case, I have a 2.8Ghz P4 as the client, hammering
a poor defenceless 1Ghz VIA C3.

This is probably worth creating a bugzilla entry for.

		Dave

