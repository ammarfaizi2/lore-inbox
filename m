Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269852AbUJHL0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269852AbUJHL0K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 07:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269853AbUJHLZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 07:25:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7810 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269840AbUJHLWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 07:22:25 -0400
Message-ID: <41667865.2000804@RedHat.com>
Date: Fri, 08 Oct 2004 07:22:13 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Clemens Schwaighofer <cs@tequila.co.jp>
CC: nfs@lists.sourceforge.net,
       Linux filesystem caching discussion list 
	<linux-cachefs@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFS using CacheFS
References: <4161B664.70109@RedHat.com> <41661950.5070508@tequila.co.jp>
In-Reply-To: <41661950.5070508@tequila.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Schwaighofer wrote:

> brr :) why is it posix, this is so out of the context for me (as a
> user). Is it possible to have a cachefs flag. Would make it more logical.

Because it was the easiest way to get things started (i.e. no userlevel
changes needed at all).... The 'fscache' flag will be coming along with
the nfs4 support, since nfs4 mounting code does not have an open
(unused) mounting flag....

SteveD.
