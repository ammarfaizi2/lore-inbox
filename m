Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268390AbRGXRpM>; Tue, 24 Jul 2001 13:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268391AbRGXRpC>; Tue, 24 Jul 2001 13:45:02 -0400
Received: from marine.sonic.net ([208.201.224.37]:23328 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S268390AbRGXRot>;
	Tue, 24 Jul 2001 13:44:49 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Tue, 24 Jul 2001 10:44:53 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Optimization for use-once pages
Message-ID: <20010724104453.G5835@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0107241405230.20326-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24, 2001 at 02:07:32PM -0300, Rik van Riel wrote:
> > I hate to bother you directly, but I don't wish to start a flame
> > war on lkml. How exactly would you explain two accesses as
> > being "used once"?
> 
> Because they occur in a very short interval, an interval MUCH
> shorter than the time scale in which the VM subsystem looks at
> referenced bits, etc...


Would mmap() then a for(;;) loop over the range be an example of such a
use?

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
