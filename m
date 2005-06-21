Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbVFUXWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbVFUXWE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 19:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbVFUWti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:49:38 -0400
Received: from mail.dvmed.net ([216.237.124.58]:42921 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262442AbVFUWpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 18:45:41 -0400
Message-ID: <42B8987F.9000607@pobox.com>
Date: Tue, 21 Jun 2005 18:45:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
CC: Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
References: <20050620235458.5b437274.akpm@osdl.org>  <42B831B4.9020603@pobox.com> <1119368364.3949.236.camel@betsy> <Pine.LNX.4.62.0506211222040.21678@graphe.net>
In-Reply-To: <Pine.LNX.4.62.0506211222040.21678@graphe.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Tue, 21 Jun 2005, Robert Love wrote:
> 
> 
>>>We should ask hpa what he needs for kernel.org.  Ideally kernel.org 
>>>probably wants <something> that facilitates listening to <something> for 
>>>a list of files being changed.  That would greatly speed up the robots, 
>>>and possibly rsync-like activities too.
>>
>>I've talked to some people who've hooked inotify into rsync
>>successfully.  Cool hack.
> 
> 
> I noticed that select() is not working on real files. Could inotify 
> be used to fix select()?

Non-blocking file I/O is an open issue.

AIO is probably a better path.

	Jeff



