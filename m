Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWAKMzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWAKMzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWAKMzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:55:32 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:47009 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751472AbWAKMzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:55:32 -0500
Date: Wed, 11 Jan 2006 06:56:42 -0600
From: John Hesterberg <jh@sgi.com>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Matt Helsley <matthltc@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Jay Lan <jlan@engr.sgi.com>,
       LKML <linux-kernel@vger.kernel.org>, elsa-devel@lists.sourceforge.net,
       lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit Connectors
Message-ID: <20060111125642.GC12921@sgi.com>
References: <43BC1C43.9020101@engr.sgi.com> <1136414431.22868.115.camel@stark> <20060104151730.77df5bf6.akpm@osdl.org> <1136486566.22868.127.camel@stark> <1136488842.22868.142.camel@stark> <20060105151016.732612fd.akpm@osdl.org> <1136505973.22868.192.camel@stark> <yq08xttybrx.fsf@jaguar.mkp.net> <43BE9E91.9060302@watson.ibm.com> <yq0wth72gr6.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0wth72gr6.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 05:36:29AM -0500, Jes Sorensen wrote:
> I think task_notify it should be usable for statistics gathering as
> well, the only issue is how to attach it to the processes we wish to
> gather accounting for. Personally I am not a big fan of the current
> concept where statistics are gathered for all tasks at all time but
> just not exported until accounting is enabled.

I believe the accounting our customers require needs to be turned on
system-wide.  In fact, I recall getting problems reports if there are
some processes not 'accounted' for.  If you do it on a task basis,
and accounting gets turned on, you'd have to have a fool-proof way
of tracking down all the tasks in a system and turn on their accounting.

I would expect sites either want accounting on all the time for
everything, or not at all.

John
