Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWFZR6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWFZR6D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWFZR6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:58:01 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:5589 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751236AbWFZR6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:58:00 -0400
Subject: Re: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver
	initialization issue fix
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: vgoyal@in.ibm.com, Maneesh Soni <maneesh@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Neela.Kolli@engenio.com,
       linux-scsi@vger.kernel.org, mike.miller@hp.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <m14py7u88m.fsf@ebiederm.dsl.xmission.com>
References: <20060623235553.2892f21a.akpm@osdl.org>
	 <20060624111954.GA7313@in.ibm.com> <20060624043046.4e4985be.akpm@osdl.org>
	 <20060624120836.GB7313@in.ibm.com>
	 <m1veqqxyrb.fsf@ebiederm.dsl.xmission.com>
	 <20060626021100.GA12824@in.ibm.com> <20060626133504.GA8985@in.ibm.com>
	 <m11wtcvw5k.fsf@ebiederm.dsl.xmission.com>
	 <20060626153239.GD8985@in.ibm.com>
	 <m13bdrvrd4.fsf@ebiederm.dsl.xmission.com>
	 <20060626171659.GG8985@in.ibm.com>
	 <m14py7u88m.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 12:56:47 -0500
Message-Id: <1151344607.2673.14.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 11:39 -0600, Eric W. Biederman wrote:
> In the general case resets are trivial operations.  In scsi land 
> things are different.  So a solution appropriate to that domain may
> be appropriate.

That's not necessarily true. You're talking about board level resets
here.  Some devices take quite a while to reboot after being reset ...
particularly the complex ones with internal operating system type
firmware ..

James


