Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268694AbTGIWoM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 18:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268695AbTGIWoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 18:44:11 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:17371 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S268694AbTGIWoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 18:44:07 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: 2.5.74-mm1
Date: Thu, 10 Jul 2003 00:59:57 +0200
User-Agent: KMail/1.5.2
Cc: Davide Libenzi <davidel@xmailserver.org>, Mel Gorman <mel@csn.ul.ie>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
References: <20030703023714.55d13934.akpm@osdl.org> <200307082027.13857.phillips@arcor.de> <20030709222426.GA24923@mail.jlokier.co.uk>
In-Reply-To: <20030709222426.GA24923@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307100059.57398.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 July 2003 00:24, Jamie Lokier wrote:
> Daniel Phillips wrote:
> > We've got something better than we've had before, even though it doesn't
> > go as far as making true realtime processing available to normal users.
>
> Indeed.  But maybe true (bounded CPU) realtime, reliable, would more
> accurately reflect what the user actually wants for some apps?

No doubt about it.  Other OSes have it:

   http://www.chemie.fu-berlin.de/cgi-bin/man/sgi_irix?realtime+5

Hopefully in the next cycle, we will too.

I like your idea of allowing normal users to set SCHED_RR, but automatically 
placing some bound on cpu usage.  It's guaranteed not to break any existing 
programs.

Regards,

Daniel

