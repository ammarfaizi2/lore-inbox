Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTJ3BBk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 20:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbTJ3BBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 20:01:40 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:26387 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S262110AbTJ3BBh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 20:01:37 -0500
Date: Wed, 29 Oct 2003 17:01:26 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [cgl_discussion] RE: ANNOUNCE: User-space System Device Enumation	(uSDE)
Message-ID: <20031030010126.GF12626@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <OF3ACB2DB7.10C92CBA-ONC1256DCE.00538D5B@netfr.alcatel.fr> <20031029190715.GA4241@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031029190715.GA4241@kroah.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message may contain content offensive to the humour impaired.  Read at your own risk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 29, 2003 at 11:07:16AM -0800, Greg KH wrote:
> On Wed, Oct 29, 2003 at 05:20:01PM +0100, Eric.Chacron@alcatel.fr wrote:
> > 
> > 
> > >From a pure technical point of view  and from presentations made by the
> > authors of u*** perspective
> > i think uSDE could add some interresting features like a customizable
> > naming policy.
> 
> udev doesn't provide such a feature right now?
> 
> > For instance: geographical addressing to identify devices using rack,
> > subrack, slot numbers seems possible.
> 
> Sure, udev can do that today, if you have a way of identifying devices
> in such a manner.

.From a distance this udev vs uSDE remind me of dm vs evms.
Based on the rhetoric udev is oriented toward implementing
policy and uSDE, articulating policy.  It seems to me that
the code that should be run on device add and remove ought
to be implementation oriented not policy oriented.  When
policy articulation is wanted it belongs in the user
interface.  This could be a set of files to build the final
config file or a library and user interface.   A bit like
using EVMS to manage dm.

Just my $0.02 in case distance lends perspective.

I also wonder how one is supposed to pronounce uSDE,
you-zdee, us-dee, us-day?

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
