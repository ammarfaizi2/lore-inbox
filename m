Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbTHYKVk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 06:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTHYKVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 06:21:40 -0400
Received: from vaxjo.synopsys.com ([198.182.60.75]:9439 "EHLO
	vaxjo.synopsys.com") by vger.kernel.org with ESMTP id S261649AbTHYKVi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 06:21:38 -0400
Date: Mon, 25 Aug 2003 12:21:33 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O18.1int
Message-ID: <20030825102133.GA14402@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	linux-kernel@vger.kernel.org
References: <200308231555.24530.kernel@kolivas.org> <yw1xr83accpa.fsf@users.sourceforge.net> <20030825094240.GJ16080@Synopsys.COM> <200308252016.13315.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200308252016.13315.kernel@kolivas.org>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas, Mon, Aug 25, 2003 12:16:13 +0200:
> On Mon, 25 Aug 2003 19:42, Alex Riesen wrote:
> > Måns Rullgård, Mon, Aug 25, 2003 11:24:01 +0200:
> > > XEmacs still spins after running a background job like make or grep.
> > > It's fine if I reverse patch-O16.2-O16.3. The spinning doesn't happen
> > > as often, or as long time as with O16.3, but it's there and it's
> > > irritating.
> >
> > another example is RXVT (an X terminal emulator). Starts spinnig after
> > it's child has exited. Not always, but annoyingly often. System is
> > almost locked while it spins (calling select).
> 
> What does vanilla kernel do with these apps running? Both immediately after 
> the apps have started up and some time (>1 min) after they've been running?
> 

cannot test atm. Will do in 10hours.
RXVT behaved sanely (or probably spin-effect is very rare) in 2.4 (with
O(1) alone and your 2.4 patches) and plain 2.6-test1.

