Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbTD3QxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 12:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbTD3QxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 12:53:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44856 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S262217AbTD3QxP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 12:53:15 -0400
To: Gabriel Paubert <paubert@iram.es>
Cc: Jamie Lokier <jamie@shareable.org>, Andi Kleen <ak@suse.de>,
       joe briggs <jbriggs@briggsmedia.com>, linux-kernel@vger.kernel.org
Subject: Re: software reset
References: <200304291037.13598.jbriggs@briggsmedia.com.suse.lists.linux.kernel>
	<p73vfwx2uw8.fsf@oldwotan.suse.de>
	<20030430075004.GB13859@mail.jlokier.co.uk>
	<m1llxsfdpg.fsf@frodo.biederman.org> <20030430161525.GA3834@iram.es>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Apr 2003 11:02:41 -0600
In-Reply-To: <20030430161525.GA3834@iram.es>
Message-ID: <m1he8fgbpq.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Paubert <paubert@iram.es> writes:

> On Wed, Apr 30, 2003 at 05:04:59AM -0600, Eric W. Biederman wrote:
> > 
> > And as an interesting data point all a triple fault does on a modern
> > system is to put the cpu in a weird stopped state.  Some hardware
> > usually the southbridge then detects this and if properly configured
> > will trigger the reset line.
> > 
> > I believe this may actually go back into history as far as the 486 but
> > I have not done the researched to see how far back this behavior goes.
> 
> Try 286. It was the fastest (actually only) way to make a 286 switch back
> from protected to real mode.

A triple fault would put a 286 into coma mode?  And the hardware had to
reset the chip?

Just trying to be clear on what you are saying.

Eric
