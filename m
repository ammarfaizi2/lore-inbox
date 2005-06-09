Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbVFIDJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbVFIDJQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 23:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVFIDJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 23:09:16 -0400
Received: from stark.xeocode.com ([216.58.44.227]:7363 "EHLO stark.xeocode.com")
	by vger.kernel.org with ESMTP id S262247AbVFIDJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 23:09:09 -0400
To: Mark Lord <liml@rtr.ca>
Cc: Greg Stark <gsstark@mit.edu>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: SMART support for libata
References: <87y8g8r4y6.fsf@stark.xeocode.com> <41B7EFA3.8000007@pobox.com>
	<87br6g6ayr.fsf@stark.xeocode.com> <42A73E6E.80808@rtr.ca>
In-Reply-To: <42A73E6E.80808@rtr.ca>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 08 Jun 2005 23:08:59 -0400
Message-ID: <873brs5ir8.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Lord <liml@rtr.ca> writes:

> Greg Stark wrote:
> >
> > getting really hot so I put it to sleep with "hdparm -Y".
> > Now whenever smartd probes that drive my system freezes for a few seconds and
> > I get this in my syslog:
> > Jun  8 12:49:36 stark kernel: hda: status timeout: status=0xd0 { Busy }
> > Jun  8 12:49:36 stark kernel: Jun  8 12:49:36 stark kernel: ide: failed
> > opcode was: 0xe5
> 
> That is normal and expected behaviour.
> A "sleeping" drive never responds to commands
> until woken with a reset.

I'm fine with errors and SMART failing to get any data. 

It's the part about my entire computer freezing for 5-10s
that doesn't seem kosher to me.

> You should be using "-y" (standby) instead of "-Y" (sleep).

I'll try that. But that's not going to make it spin up when it gets a SMART
query is it?

-- 
greg

