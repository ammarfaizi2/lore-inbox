Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVAGPMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVAGPMj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 10:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVAGPMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 10:12:39 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:17597 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261447AbVAGPMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 10:12:37 -0500
Date: Fri, 7 Jan 2005 07:12:23 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com, greghk@us.ibm.com
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050107151223.GA1267@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <1105083213.4179.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105083213.4179.1.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 08:33:32AM +0100, Arjan van de Ven wrote:
> On Thu, 2005-01-06 at 13:04 -0800, Paul E. McKenney wrote:
> > On Thu, Jan 06, 2005 at 08:32:59PM +0000, Al Viro wrote:
> > > On Thu, Jan 06, 2005 at 12:15:31PM -0800, Paul E. McKenney wrote:
> > > > Yep, you win the prize, it is MVFS.
> > > > 
> > > > This is the usual port of an existing body of code to the Linux kernel.
> > > > It is not asking for a new export, only restoration of a previously existing
> > > > export.
> > > 
> > > Sorry, but "our code is badly misdesigned" does not make a valid excuse
> > > when you have been told, repeatedly, by many people, for at least a year
> > > that you needed to sanitize your design.
> > 
> > The obvious searches did not find this for me.  Any pointers so that
> > I can bring to the MVFS guys' attention any alternatives that might
> > have been recommended?
> 
> eh maybe a weird question, but why are you and not the MVFS guys asking
> for this export then? They can probably better explain why they need
> it ....

As near as I can tell, they believe that they already did the best they
could to explain their needs and failed to do so.

							Thanx, Paul
