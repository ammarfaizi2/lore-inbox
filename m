Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTLJXTt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 18:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264273AbTLJXTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 18:19:49 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:44038 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264272AbTLJXTs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 18:19:48 -0500
Date: Thu, 11 Dec 2003 00:30:50 +0100
To: William Lee Irwin III <wli@holomorphy.com>,
       Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031210233050.GA16653@hh.idb.hist.no>
References: <200311032113.14462.chris@cvine.freeserve.co.uk> <200311041355.08731.kernel@kolivas.org> <20031208135225.GT19856@holomorphy.com> <20031208194930.GA8667@k3.hellgate.ch> <20031208204817.GA19856@holomorphy.com> <20031209002745.GB8667@k3.hellgate.ch> <20031209040501.GE19856@holomorphy.com> <20031209151103.GA4837@k3.hellgate.ch> <20031209193801.GF19856@holomorphy.com> <20031210135829.GA18370@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031210135829.GA18370@k3.hellgate.ch>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 02:58:29PM +0100, Roger Luethi wrote:
> 
> What goes wrong is that once you start suspending tasks, you have a
> hard time telling the interactive tasks apart from the batch load.
> This may not be much of a problem on a 10x overcommit system, because
> that's presumably quite unresponsive anyway, but it does matter a lot if
> you have an interactive system that just crossed the border to thrashing.
> 
This isn't too bad.  Lets say I use the system interavtively and the "wrong"
app suddenly is swapped out.  I notice this, and simply close
down some responsive apps that are less needed.  The system
will then notice that there's "enough" memory and allow
the app to page in again.

Helge Hafting
