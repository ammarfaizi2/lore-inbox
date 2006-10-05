Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWJEQFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWJEQFN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWJEQFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:05:12 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:44692 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932158AbWJEQFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:05:10 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 5 Oct 2006 17:05:04 +0100
From: Tony Finch <dot@dotat.at>
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
To: David Woodhouse <dwmw2@infradead.org>
cc: Dennis Heuer <dh@triple-media.com>, linux-kernel@vger.kernel.org,
       dot@dotat.at
Subject: Re: sunifdef instead of unifdef
In-Reply-To: <1160059253.26064.69.camel@pmac.infradead.org>
Message-ID: <Pine.LNX.4.64.0610051648200.28237@hermes-2.csi.cam.ac.uk>
References: <20061005150816.76ca18c2.dh@triple-media.com>
 <1160059253.26064.69.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006, David Woodhouse wrote:
>
> I wouldn't describe it as 'very old' -- the last commit seems to have
> been last March, which isn't _so_ recent but perhaps it just hasn't
> _needed_ an update?
>
> Neither would I describe it as unmaintained. Tony was quite quickly
> responsive when I asked him if it would be OK to include unifdef in the
> kernel source tree.

I haven't received any contributions to unifdef in the last 18 months
which is why it hasn't changed. Yes, it has some significant gaps in its
functionality, but it's reasonably correct within its current scope. (I
tend to think that if you need more advanced functionality then you are
already in serious trouble: for example, my unifdef was written so that I
could understand xterm's frightening pty handling....) I don't have a lot
of time to make extensive changes to unifdef, and given that sunifdef
exists there is not much point. Thanks for telling me about it: I didn't
know it existed, and it's nice to see other people basing such great stuff
on my work.

> I don't see a huge point in changing, unless it lets us get rid of stuff
> like
> 	#if defined(__KERNEL__ && ....

I don't think your syntax errors are my problem :-)

Tony.
-- 
f.a.n.finch  <dot@dotat.at>  http://dotat.at/
FORTIES CROMARTY FORTH: SOUTHERLY 6 TO GALE 8, DECREASING 5 OR 6 LATER. RAIN
OR SHOWERS. MODERATE OR GOOD.
