Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbTIKP0C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbTIKP0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:26:02 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:50321 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261420AbTIKPZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:25:58 -0400
Subject: Re: ide-scsi oops was: 2.6.0-test4-mm3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20030910191016.GC1461@matchmail.com>
References: <20030828235649.61074690.akpm@osdl.org>
	 <20030910185338.GA1461@matchmail.com> <20030910185537.GB1461@matchmail.com>
	 <20030910114346.025fdb59.akpm@osdl.org>
	 <20030910191016.GC1461@matchmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063293875.2967.26.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Thu, 11 Sep 2003 16:24:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-10 at 20:10, Mike Fedyk wrote:
> On Wed, Sep 10, 2003 at 11:43:46AM -0700, Andrew Morton wrote:
> > Mike Fedyk <mfedyk@matchmail.com> wrote:
> > >
> > > I have another oops for you with 2.6.0-test4-mm3-1 and ide-scsi. 
> > 
> > ide-scsi is a dead duck.  defunct.  kaput.  Don't use it.  It's only being
> 
> Ok, I gotcha.
> 
> > kept around for weirdo things like IDE-based tape drives, scanners, etc.
> > 
> 
> But will those devices hit the same code paths that my cp did?

Yes so it does still need fixing.

