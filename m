Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbUBDSrj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 13:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbUBDSrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 13:47:39 -0500
Received: from peabody.ximian.com ([130.57.169.10]:2978 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S264245AbUBDSri
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 13:47:38 -0500
Subject: Re: [patch] 2.4's sys_readahead is borked
From: Robert Love <rml@ximian.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <40213CFD.5090802@matchmail.com>
References: <1075853962.8022.3.camel@localhost>
	 <Pine.LNX.4.58L.0402041224050.1700@logos.cnet>
	 <1075908048.11309.6.camel@localhost>  <40213CFD.5090802@matchmail.com>
Content-Type: text/plain
Message-Id: <1075920451.13072.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Wed, 04 Feb 2004 13:47:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-04 at 10:42 -0800, Mike Fedyk wrote:

> Robert Love wrote:
>
> > Not really - I've been playing with it.  But OpenOffice just added it to
> > preload some of their libraries.  It should probably be deprecated and
> > remove in 2.7, since posix_fadvise(POSIX_FADV_WILLNEED) does this same
> > thing.
> 
> In 2.4 also?

No, posix_fadvise() is only in 2.6.

So we deprecate readahead() in 2.7...

	Robert Love


