Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbTGDTkO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 15:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbTGDTkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 15:40:14 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:58123 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S266147AbTGDTkK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 15:40:10 -0400
Date: Fri, 4 Jul 2003 22:00:46 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: zboszor@freemail.hu, linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
Message-ID: <20030704200046.GA1167@hh.idb.hist.no>
References: <3F0407D1.8060506@freemail.hu> <3F042AEE.2000202@freemail.hu> <20030703122243.51a6d581.akpm@osdl.org> <20030703200858.GA31084@hh.idb.hist.no> <20030703141508.796e4b82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703141508.796e4b82.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 02:15:08PM -0700, Andrew Morton wrote:
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
[...]
> > I may have this problem on my dual celeron.  I noticed X got sluggish
> > while generating a key for mozilla - very strange on a dual
> > but I put it down to the scheduler changes.
> > 
> > Looking at dmesg I see that both is detected, and it claims
> > both are "activated", but I get this a little later:
[...] 
> ok.  If you're feeling keen could you please revert the cpumask_t patch.
> 
> And please send the .config, thanks.

I'm sorry, both cpu's are up.  I did a better test
with busy loops.  One high-priority (nice --10)
busy loop has no effect on performance, two such ones
makes the mouse cursor very jumpy. 

So both cpus are working, after all and not merely being
detected.  I'm using gcc 3.3 from debian testing.

Helge Hafting
