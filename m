Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270238AbUJUErD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270238AbUJUErD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 00:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270557AbUJUEmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 00:42:15 -0400
Received: from out004pub.verizon.net ([206.46.170.142]:20132 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S270238AbUJUEiY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 00:38:24 -0400
Message-ID: <41773D3F.2040801@verizon.net>
Date: Thu, 21 Oct 2004 00:38:23 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Structural changes for Documentation directory
References: <4176CFE3.2030306@verizon.net> <20041020153058.6de41ed8.akpm@osdl.org> <4176EBD8.3050306@verizon.net> <20041021042036.GB14189@redhat.com>
In-Reply-To: <20041021042036.GB14189@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [209.158.211.53] at Wed, 20 Oct 2004 23:38:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Wed, Oct 20, 2004 at 06:51:04PM -0400, Jim Nelson wrote:
> 
>  > True.  "./2.6-docs" would reflect the the intent of having 
>  > version-specific information, with the "./Documentation" directory left 
>  > for general information and files of historical interest.
> 
> version numbers in directories are nearly always a bad idea,
> as they always tend to look a bit silly when the subsequent
> release is made.
> 
> 		Dave
> 
> 

But it would also give a clue that the docs are out of date.  Perhaps 
later in each developement cycle, there could be an effort to check the 
documentation, with a 2.8-docs or 3.0-docs being the result, and dumping 
the 2.6-docs into the historical reference directory.

Or, the old stuff could be dropped with the new stable release.

The other possibility is to have a TODO file with a list of out-of-date 
files, and have the removal of the file listing in the TODO file be part 
of the patch submission.

Jim
