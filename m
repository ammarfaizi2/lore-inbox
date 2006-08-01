Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751689AbWHAPdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbWHAPdA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 11:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbWHAPc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 11:32:59 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:35299 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751682AbWHAPc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 11:32:59 -0400
Subject: Re: [RFC] /dev/itimer
From: Steven Rostedt <rostedt@goodmis.org>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Edgar Toernig <froese@gmx.de>, linux-kernel@vger.kernel.org,
       Bill Huey <billh@gnuppy.monkey.org>
In-Reply-To: <1154443252.44cf67f4dd562@domainfactory-webmail.de>
References: <20060728235951.7de534eb.froese@gmx.de>
	 <1154443252.44cf67f4dd562@domainfactory-webmail.de>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 11:32:34 -0400
Message-Id: <1154446354.25983.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 16:40 +0200, Clemens Ladisch wrote:
> Edgar Toernig wrote:
> > this is a simple driver which provides interval timers via
> > file descriptors.
> 
> Interval timers are already available with ALSA (although ALSA's timer
> API is neither as simple nor as script-friendly as this one).

A generic timer interface like this one should not depend on sound
support.  As Bill Huey has mentioned, something like this would be good
on RT embedded systems, and ALSA is not something I would want to add to
an embedded system if I didn't need to.

-- Steve


