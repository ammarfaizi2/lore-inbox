Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbVDGQ7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbVDGQ7w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 12:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbVDGQ7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 12:59:52 -0400
Received: from smtp.istop.com ([66.11.167.126]:21213 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262527AbVDGQ7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 12:59:38 -0400
From: Daniel Phillips <phillips@istop.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Kernel SCM saga..
Date: Thu, 7 Apr 2005 13:00:51 -0400
User-Agent: KMail/1.7
Cc: Paul Mackerras <paulus@samba.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <16980.55403.190197.751840@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0504070747580.28951@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504070747580.28951@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504071300.51907.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 April 2005 11:10, Linus Torvalds wrote:
> On Thu, 7 Apr 2005, Paul Mackerras wrote:
> > Do you have it automated to the point where processing emailed patches
> > involves little more overhead than doing a bk pull?
>
> It's more overhead, but not a lot. Especially nice numbered sequences like
> Andrew sends (where I don't have to manually try to get the dependencies
> right by trying to figure them out and hope I'm right, but instead just
> sort by Subject: line)...

Hi Linus,

In that case, a nice refinement is to put the sequence number at the end of 
the subject line so patch sequences don't interleave:

   Subject: [PATCH] Unbork OOM Killer (1 of 3)
   Subject: [PATCH] Unbork OOM Killer (2 of 3)
   Subject: [PATCH] Unbork OOM Killer (3 of 3)
   Subject: [PATCH] Unbork OOM Killer (v2, 1 of 3)
   Subject: [PATCH] Unbork OOM Killer (v2, 2 of 3)
   ...

Regards,

Daniel
