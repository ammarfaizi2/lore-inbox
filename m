Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbTIJUx4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 16:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265512AbTIJUx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 16:53:56 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:10422 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262743AbTIJUxz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 16:53:55 -0400
Subject: Re: ide-scsi oops was: 2.6.0-test4-mm3
From: Paul Larson <plars@linuxtestproject.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, Mike Fedyk <mfedyk@matchmail.com>,
       lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <10720000.1063224243@flay>
References: <20030828235649.61074690.akpm@osdl.org><20030910185338.GA1461@matchmail.com>
	<20030910185537.GB1461@matchmail.com>
	<20030910114346.025fdb59.akpm@osdl.org>  <10720000.1063224243@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 10 Sep 2003 15:53:43 -0500
Message-Id: <1063227224.15603.31.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-10 at 15:04, Martin J. Bligh wrote:
> >> I have another oops for you with 2.6.0-test4-mm3-1 and ide-scsi. 
> > 
> > ide-scsi is a dead duck.  defunct.  kaput.  Don't use it.  It's only being
> > kept around for weirdo things like IDE-based tape drives, scanners, etc.
> > 
> > Just use /dev/hdX directly.
> 
> That's a real shame ... it seemed to work fine until recently. Some
> of the DVD writers (eg the one I have - Sony DRU500A or whatever)
> need it. Is it unfixable? or just nobody's done it?
If it is going to be left to rot, then should there be a CONFIG_OBSOLETE
(or something to that effect) for things that are being considered for
removal?  This would be in the same spirit as CONFIG_CLEAN_COMPILE and
would give people a chance to yell if they have a legitimate case to
continue support.

-Paul Larson


