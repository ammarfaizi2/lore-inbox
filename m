Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbULUU5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbULUU5a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 15:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbULUU5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 15:57:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40140 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261855AbULUU52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 15:57:28 -0500
Date: Tue, 21 Dec 2004 15:57:17 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Arun C Murthy <acmurthy@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: at_fork & at_exit
In-Reply-To: <41C835C7.2010203@gmail.com>
Message-ID: <Pine.LNX.4.61.0412211556290.12392@chimarrao.boston.redhat.com>
References: <41C835C7.2010203@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2004, Arun C Murthy wrote:

> Im looking for linux equivalent of the FreeBSD calls:
>
> 1. at_fork
> 2. at_exit

> Specifically im on RHEL3... any pointers are appreciated...

What do you want to use them for ?

If it is for security logging, it may be an option to use
the syscall auditing code ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
