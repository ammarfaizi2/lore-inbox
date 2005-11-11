Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVKKVSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVKKVSe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 16:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVKKVSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 16:18:33 -0500
Received: from terminus.zytor.com ([192.83.249.54]:4805 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751203AbVKKVSc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 16:18:32 -0500
Message-ID: <43750A9D.7070400@zytor.com>
Date: Fri, 11 Nov 2005 13:18:21 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Junio C Hamano <junkio@cox.net>
CC: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] GIT 0.99.9g
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>	<43737EC7.6090109@zytor.com> <7v4q6k1jp0.fsf@assigned-by-dhcp.cox.net>
In-Reply-To: <7v4q6k1jp0.fsf@assigned-by-dhcp.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> 
>>May I *STRONGLY* urge you to name that something different. 
>>"lost+found" is a name with special properties in Unix; for example, 
>>many backup solutions will ignore a directory with that name.
> 
> 
> Yeah, the original proposal (in TODO list) explicitly stated why
> I chose lost-found instead of lost+found back then, and somebody
> on the list (could have been Pasky but I may be mistaken) said
> not to worry.  In any case, if we go the route Daniel suggests,
> we would not be storing anything on the filesystem ourselves so
> this would be a non-issue.
> 

Just realized one more issue with this... a lot of non-Unix filesystems 
can't deal with files with a + sign.

	-hpa
