Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265490AbTIJTK0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265498AbTIJTKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:10:25 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:15111
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S265490AbTIJTKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:10:20 -0400
Date: Wed, 10 Sep 2003 12:10:16 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: ide-scsi oops was: 2.6.0-test4-mm3
Message-ID: <20030910191016.GC1461@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030828235649.61074690.akpm@osdl.org> <20030910185338.GA1461@matchmail.com> <20030910185537.GB1461@matchmail.com> <20030910114346.025fdb59.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910114346.025fdb59.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 11:43:46AM -0700, Andrew Morton wrote:
> Mike Fedyk <mfedyk@matchmail.com> wrote:
> >
> > I have another oops for you with 2.6.0-test4-mm3-1 and ide-scsi. 
> 
> ide-scsi is a dead duck.  defunct.  kaput.  Don't use it.  It's only being

Ok, I gotcha.

> kept around for weirdo things like IDE-based tape drives, scanners, etc.
> 

But will those devices hit the same code paths that my cp did?

> Just use /dev/hdX directly.

Will do. (actually doing.  I have a really bad cd-rom that insists on
spinning down after each request -- or maybe large seek, not sure.  Needs
replacement.)
