Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262915AbUJ1ViF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbUJ1ViF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 17:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbUJ1Vfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 17:35:55 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:4206 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263101AbUJ1VTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 17:19:02 -0400
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: [patch 2/7] uml: Build fix for TT w/o SKAS
Date: Thu, 28 Oct 2004 23:19:47 +0200
User-Agent: KMail/1.7.1
Cc: akpm@osdl.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
References: <200410272223.i9RMNg921807@mail.osdl.org> <200410282049.42376.blaisorblade_spam@yahoo.it> <20041028192924.GD851@taniwha.stupidest.org>
In-Reply-To: <20041028192924.GD851@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410282319.48140.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 21:29, Chris Wedgwood wrote:
> On Thu, Oct 28, 2004 at 08:49:42PM +0200, Blaisorblade wrote:
> > Drop that - the fix is in my tree currently, I'll forward it
> > soon. And the fix, instead of #ifdef'ing it out, adds the support
> > for using TT & SYSEMU.

> SKAS / SYSEMU are entirely uninteresting right now until the host OS
> support for these gets merged

Well, this is completely questionable. Even if SKAS3 will never be merged in 
mainline on the host side, the SKAS3 support in UML has already been merged. 
And I think SYSEMU will be much more welcome than those patches (in fact, 
it's completely independent from the SKAS patch).

For an earlier discussion, see:

http://www.kerneltraffic.org/kernel-traffic/kt20030106_199.html#4

And even if SKAS3 will not be merged, SKAS4 will, and the current UML SKAS 
code should need just a very few changes. While having the code in mainline 
is important to get it fixed with API changes.

> i really don't think it's a good enough reason to hold other things up
> and i'd prefer to see the fixes go in as-is and further updates ontop
> of these

This would be generally right, but for now, please hold on until next -rc.
Sorry for the problem and thanks for the help!
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

