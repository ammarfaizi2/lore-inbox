Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264561AbUD2Otr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbUD2Otr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 10:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264707AbUD2Otr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 10:49:47 -0400
Received: from florence.buici.com ([206.124.142.26]:54151 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264561AbUD2Otm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 10:49:42 -0400
Date: Thu, 29 Apr 2004 07:49:41 -0700
From: Marc Singer <elf@buici.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040429144941.GC708@buici.com>
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40904A84.2030307@yahoo.com.au> <20040429005801.GA21978@buici.com> <40907AF2.2020501@yahoo.com.au> <20040429042047.GB26845@buici.com> <409083E9.2080405@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409083E9.2080405@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 02:26:17PM +1000, Nick Piggin wrote:
> Yes it includes something which should help that. Along with
> the "split active lists" that I mentioned might help your
> problem when WLI first came up with the change to the
> swappiness calculation for your problem.
> 
> It would be great if you had time to give my patch a run.
> It hasn't been widely stress tested yet though, so no
> production systems, of course!

As I said, I'm game to have a go.  The trouble was that it doesn't
apply.  My development kernel has an RMK patch applied that seems to
conflict with the MM patch on which you depend.

