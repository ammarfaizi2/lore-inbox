Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbTJJAaI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 20:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTJJAaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 20:30:08 -0400
Received: from node-423a141a.mdw.onnet.us.uu.net ([66.58.20.26]:35582 "EHLO
	topaz") by vger.kernel.org with ESMTP id S262681AbTJJAaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 20:30:05 -0400
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pmdisk performance problem
References: <Pine.LNX.4.44.0310091235340.985-100000@localhost.localdomain>
From: Narayan Desai <desai@mcs.anl.gov>
Date: Thu, 09 Oct 2003 19:29:52 -0500
In-Reply-To: <Pine.LNX.4.44.0310091235340.985-100000@localhost.localdomain> (Patrick
 Mochel's message of "Thu, 9 Oct 2003 12:36:10 -0700 (PDT)")
Message-ID: <877k3e9bpb.fsf@mcs.anl.gov>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pat" == Patrick Mochel <mochel@osdl.org> writes:

  Pat> Do you know if this was just for the write operation, or also
  Pat> included stopping all processes?
  >>
  >> This was during the write of ~4600 pages to disk.

  Pat> Hm, that's definitely bad.

  Pat> Could you increase the log-level before you suspend and let me
  Pat> know -- by looking at the debug messages -- what seems to take
  Pat> the most time?
  >>
  >> sorry, but how do i do this?

the particular line that takes the most time is the writing 4700 pages
to disk followed by the dots. each dot takes about 10 seconds to
appear on screen.

I also notice that both hda and hdc are both suspended and resumed
before this point. Is this intentional?
 -nld

