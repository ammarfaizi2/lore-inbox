Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbUBDRZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 12:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbUBDRZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 12:25:28 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:29160 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263832AbUBDRZ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 12:25:26 -0500
Subject: Re: 2.6 probe.c "pcibus_class" Device Class, release function
From: John Rose <johnrose@austin.ibm.com>
To: colpatch@us.ibm.com
Cc: greg KH <gregkh@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1075910719.3026.2.camel@verve>
References: <1075847619.28337.31.camel@verve>  <40204B7E.6030408@us.ibm.com>
	 <1075910444.3026.0.camel@verve>  <1075910719.3026.2.camel@verve>
Content-Type: text/plain
Message-Id: <1075915328.3026.16.camel@verve>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 04 Feb 2004 11:22:08 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After testing, it would appear that it does.  Perfect!  Thanks.

John

On Wed, 2004-02-04 at 10:05, John Rose wrote:
> Oops - quick question.  Does unregistering blow away the cpuaffinity
> attr and the bridge symlink?
> 
> Thanks-
> John
> 
> On Wed, 2004-02-04 at 10:00, John Rose wrote:
> > >  put() does need to be 
> > > called twice because the bridge device is get()'d twice: once when the 
> > > device is registered and once when it's bus device grabs a reference to it.
> > 
> > Looks great, thanks Matt.
> > 
> > John

