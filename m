Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbVKLWiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbVKLWiN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 17:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbVKLWiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 17:38:13 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:13736 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964863AbVKLWiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 17:38:12 -0500
Date: Sat, 12 Nov 2005 14:38:56 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Chandra Seetharaman <sekharan@us.ibm.com>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Subject: [RFC][PATCH] Fix for unsafe notifier chain mechanism
Message-ID: <20051112223856.GA5709@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051112192809.GA5296@us.ibm.com> <Pine.LNX.4.44L0.0511121559260.6130-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0511121559260.6130-100000@netrider.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 04:01:02PM -0500, Alan Stern wrote:
> On Sat, 12 Nov 2005, Paul E. McKenney wrote:
> > > It's not really duplicate documentation since _both_ pointers are to be 
> > > RCU-dereferenced.  But maybe you mean that only the second pointer can be 
> > > RCU-dereferenced at the time the write occurs?  I don't think that's what 
> > > the documentation comment intended.
> > 
> > I am the guy who wrote that documentation ocmment.  ;-)
> 
> In that case I bow to your advice.  :-)

Any advice on how to change the documentation so as to make the intent
more clear would of course be most welcome!

						Thanx, Paul
