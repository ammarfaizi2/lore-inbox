Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUFWWzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUFWWzg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUFWWzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:55:36 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:36283 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261685AbUFWWzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 18:55:35 -0400
Message-ID: <40DA0A42.3050205@nortelnetworks.com>
Date: Wed, 23 Jun 2004 18:54:58 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mariusz Mazur <mmazur@kernel.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.7.0
References: <200406240020.39735.mmazur@kernel.pl>
In-Reply-To: <200406240020.39735.mmazur@kernel.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mariusz Mazur wrote:

> Llh is all good and nice, cause it works (most of the times anyway), but 
> with
> every new release the possibility of desync from kernel increases - 
> downfalls
> of maintaining it as a separate package. Could anybody point me to some
> conclusions about how the thing should be done The Right Way (preferably 
> with
> some input from high profile kernel hackers, so I can have some assurance
> that once something gets done it will get merged)?

Not a high profile hacker, but you might try submitting a patch adding an 
include/user_abi directory (or whatever it should be called) and putting one of 
your files there, with patches to the original kernel header file to remove the 
userspace bits and include the new file.  That would maybe kick off some discussion.

Chris
