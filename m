Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVDHWjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVDHWjb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 18:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVDHWjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 18:39:31 -0400
Received: from struggle.mr.itd.umich.edu ([141.211.14.79]:50049 "EHLO
	struggle.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S261177AbVDHWj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 18:39:28 -0400
Message-ID: <4257055A.7010908@umich.edu>
Date: Fri, 08 Apr 2005 18:27:38 -0400
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
>> It looks like an operation like "show me the history of mm/memory.c" will
>> be pretty expensive using git.
>
> Yes.  Per-file history is expensive in git, because if the way it is 
> indexed. Things are indexed by tree and by changeset, and there are no 
> per-file indexes.

Although directory changes are tracked using change-sets, there 
seems to be no easy way to answer "give me the diff corresponding to
the commit (change-set) object <sha1>".  That will be really helpful to
review the changes.

Rajesh
