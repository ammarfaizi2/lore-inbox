Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVFUXzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVFUXzp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 19:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVFUXz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 19:55:29 -0400
Received: from mail.dvmed.net ([216.237.124.58]:2474 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262370AbVFUXjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 19:39:15 -0400
Message-ID: <42B8A51A.8020208@pobox.com>
Date: Tue, 21 Jun 2005 19:39:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
CC: Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
References: <20050620235458.5b437274.akpm@osdl.org>  <42B831B4.9020603@pobox.com> <1119368364.3949.236.camel@betsy> <Pine.LNX.4.62.0506211222040.21678@graphe.net> <42B8987F.9000607@pobox.com> <Pine.LNX.4.62.0506211628550.25251@graphe.net>
In-Reply-To: <Pine.LNX.4.62.0506211628550.25251@graphe.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Tue, 21 Jun 2005, Jeff Garzik wrote:
> 
> 
>>Non-blocking file I/O is an open issue.
>>
>>AIO is probably a better path.
> 
> 
> AIO is requiring you to poll and check if I/O is complete. select() does 

Incorrect.  The entire point of AIO is that its an async callback 
system, when the I/O is complete...  just like the kernel's internal I/O 
request queue system.

	Jeff



