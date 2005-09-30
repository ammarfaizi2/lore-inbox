Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbVI3AsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbVI3AsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbVI3AsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:48:04 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:48069 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932457AbVI3AsC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:48:02 -0400
Date: Thu, 29 Sep 2005 19:48:00 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] ppc64: Assorted minor EEH cleanups
Message-ID: <20050930004800.GL29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following seven patches perform a variety of cleanups and restructurings
of the EEH code, in preparation for the addition of code that will recover 
from EEH events.  The frst few patches are nearly janitorial, mostly tweaking
whitespace; alhough the later patches are more serious and actually fix bugs.

These are all small, and should be easy to review.  I beleive that these
patches should not be controversial in any way, and thus should be ready
to be applied.

They compile but (ahem) are not tested, as I just now discovered that 
I cannot even boot 2.6.14-rc2-git6 in any shape or form; it panics complaining 
of "junk in gzipped archive".  Of course, I am of the firmest conviction that
my patches are spotless, and need no testing, anyway. So there. :)

Signed-off-by: Linas Vepstas <linas@linas.org>

--linas
