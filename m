Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262989AbVD2U7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbVD2U7y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbVD2U7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:59:11 -0400
Received: from peabody.ximian.com ([130.57.169.10]:43179 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262979AbVD2U6T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:58:19 -0400
Subject: Re: which ioctls matter across filesystems
From: Robert Love <rml@novell.com>
To: Steve French <smfrench@austin.rr.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
In-Reply-To: <42729F4F.2020209@austin.rr.com>
References: <42728964.8000501@austin.rr.com>
	 <1114804426.12692.49.camel@lade.trondhjem.org>
	 <1114805033.6682.150.camel@betsy>
	 <1114807360.12692.77.camel@lade.trondhjem.org>
	 <42729F4F.2020209@austin.rr.com>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 16:57:52 -0400
Message-Id: <1114808272.6682.158.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-29 at 15:55 -0500, Steve French wrote:

> I believe that the spotlight facility of MacOS, and the somewhat similar 
> Longhorn feature (think Google desktop search/indexing on steroids) 
> qualify as killer-apps.   I am concerned about how to do better with our 
> implementations across a distributed (NFS, CIFS etc.) network.   And of 
> course coalescing async notifications most efficiently is a fascinating 
> and difficult area to do right - for servers at least.

If we had some way to efficiently coalesce events, even non-remote stuff
would drool.  Beagle (our Spotlight killer) would love it.

First thing is, the events cannot be stored in a linked list. ;-)

	Robert Love


