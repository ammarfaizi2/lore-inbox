Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbUAVBEu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 20:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUAVBEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 20:04:50 -0500
Received: from gprs148-45.eurotel.cz ([160.218.148.45]:33152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264271AbUAVBEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 20:04:48 -0500
Date: Thu, 22 Jan 2004 02:04:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rik van Riel <riel@redhat.com>
Cc: Valdis.Kletnieks@vt.edu, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sched-idle and disk-priorities for 2.6.X
Message-ID: <20040122010438.GD223@elf.ucw.cz>
References: <20040118195825.GA27658@elf.ucw.cz> <Pine.LNX.4.44.0401211448250.26332-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401211448250.26332-100000@chimarrao.boston.redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Is there effective way to limit RSS?
> > > 
> > > Want me to port the RSS stuff from 2.4-rmap to 2.6 ?
> > 
> > Well, if it allows me to limit memory for one task so that it does not
> > make system unusable... yes, that would be great.
> 
> Here it is.  Untested, except for whether it compiles cleanly ;)
> 
> Let me know how it works, if the enforcement is aggressive
> enough or not, whether I need to tweak things etc...

It boots, and seems to have no ill effects. I've yet to see some good
effects, too...

doing 

ulimit -m 1
<some task>

should make that task run with extremely low priority, right?

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
