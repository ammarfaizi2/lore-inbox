Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264806AbTFLQRD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 12:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbTFLQRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 12:17:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21731 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264806AbTFLQRC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 12:17:02 -0400
Date: Thu, 12 Jun 2003 17:30:45 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       John M Flinchbaugh <glynis@butterfly.hjsoft.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: 2.5.70-bk16: nfs crash
Message-ID: <20030612163045.GK6754@parcelfarce.linux.theplanet.co.uk>
References: <20030612125630.GA19842@butterfly.hjsoft.com> <20030612135254.GA2482@in.ibm.com> <16104.40370.828325.379995@charged.uio.no> <20030612155345.GB1438@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612155345.GB1438@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 09:23:45PM +0530, Dipankar Sarma wrote:

> Lockfree d_lookup() gives us significant benefits in larger
> SMP machines.

I wonder if they outweight debugging time wasted after any change...

Note that for vfsmounts proposed RCU patch had been utterly useless -
practically all improvements had been from separate lock for vfsmounts
(see akpm tree).
