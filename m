Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVKJJJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVKJJJT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 04:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbVKJJJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 04:09:19 -0500
Received: from mail.dvmed.net ([216.237.124.58]:1260 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750701AbVKJJJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 04:09:17 -0500
Message-ID: <43730E39.6030601@pobox.com>
Date: Thu, 10 Nov 2005 04:09:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
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
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junio C Hamano wrote:
>  - One important newcomer is git-pack-redundant.  It is still in
>    "pu" not because I doubt what it does is useful, but simply
>    because I have not had a chance to study how it does its
>    thing.  I expect to fully merge it into "master" before 1.0
>    happens.

IMHO git-prune-packed should prune redundant pack files...



> Oh, and we will not be moving things out of /usr/bin/ during 1.0
> timeframe.

:(  bummer.  I do like the elegance of having /usr/bin/git executing 
stuff out of /usr/libexec/git.

/usr/libexec/git also makes it IMO cleaner when integrating git plugins 
from third parties (rpm -Uvh git-newfeature), because you don't have to 
worry about the /usr/bin namespace.

	Jeff


