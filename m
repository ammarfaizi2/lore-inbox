Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263162AbVAFVNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbVAFVNq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 16:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbVAFVJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 16:09:22 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:19369 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262997AbVAFVEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 16:04:33 -0500
Date: Thu, 6 Jan 2005 13:04:08 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com, greghk@us.ibm.com
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050106210408.GM1292@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 08:32:59PM +0000, Al Viro wrote:
> On Thu, Jan 06, 2005 at 12:15:31PM -0800, Paul E. McKenney wrote:
> > Yep, you win the prize, it is MVFS.
> > 
> > This is the usual port of an existing body of code to the Linux kernel.
> > It is not asking for a new export, only restoration of a previously existing
> > export.
> 
> Sorry, but "our code is badly misdesigned" does not make a valid excuse
> when you have been told, repeatedly, by many people, for at least a year
> that you needed to sanitize your design.

The obvious searches did not find this for me.  Any pointers so that
I can bring to the MVFS guys' attention any alternatives that might
have been recommended?

						Thanx, Paul
