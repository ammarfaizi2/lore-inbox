Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbVKJRJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbVKJRJk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 12:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVKJRJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 12:09:40 -0500
Received: from terminus.zytor.com ([192.83.249.54]:31879 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751057AbVKJRJj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 12:09:39 -0500
Message-ID: <43737EC7.6090109@zytor.com>
Date: Thu, 10 Nov 2005 09:09:27 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Junio C Hamano <junkio@cox.net>
CC: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] GIT 0.99.9g
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>
In-Reply-To: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junio C Hamano wrote:
> 
>    - Add git-lost+found.  Currently the implementation stores
>      found refs under .git/lost+found/{commit,other}
>      directories, but writing out their object names to the
>      standard output and let the users decide what to do with
>      them was suggested on the list by Daniel, which makes sense
>      as well.  There are pros and cons so until we know if it is
>      useful and if so in what form, it will not come out of "pu"
>      branch.
> 

May I *STRONGLY* urge you to name that something different. 
"lost+found" is a name with special properties in Unix; for example, 
many backup solutions will ignore a directory with that name.

	-hpa
