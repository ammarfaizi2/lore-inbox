Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267671AbUGaOxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267671AbUGaOxj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 10:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267641AbUGaOxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 10:53:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42895 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267671AbUGaOxh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 10:53:37 -0400
Date: Sat, 31 Jul 2004 11:51:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Tim Hockin <thockin@hockin.org>
Cc: Colin Paton <colin.paton@etvinteractive.com>, linux-kernel@vger.kernel.org
Subject: Re: Natsemi ethernet 'cable magic' fix can cause problems
Message-ID: <20040731145113.GF6497@logos.cnet>
References: <1084444503.4548.141.camel@colinp> <20040513170358.GA19426@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513170358.GA19426@hockin.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 10:03:58AM -0700, Tim Hockin wrote:
> On Thu, May 13, 2004 at 11:35:03AM +0100, Colin Paton wrote:
> > The problem was strange - about 30% packet loss was experienced during
> > pings. Moving the box to a different ethernet wall outlet (but still
> > using the same port on the switch) cured the problem. The problem
> > therefore appeared to be cable dependant.
> > 
> > It would appear that the call to 'do_cable_magic()' in
> > drivers/net/natsemi.c causes the problem to occur.
> > 
> > It looks as though this was added in to actually *fix* such problems...
> > but in our case it made things worse.
> 
> I'm the responsible party on that one.  do_cable_magic() was a direct
> result of a significant amount of work with National's engineers to
> root-cause some major problems we had had.
> 
> If I recall, the problem we experienced was when the cable was "short"
> (where short was < 30m, I think).  What can you tell me about your cabling
> setup?
> 
> Willing to test?  Ping me back.

Hi Tim, Collin,

Did you made any progress on this issue?
