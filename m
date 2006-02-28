Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbWB1UzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbWB1UzS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 15:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWB1UzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 15:55:18 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:37800 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932393AbWB1UzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 15:55:16 -0500
Message-ID: <4404B8A9.4020303@vilain.net>
Date: Wed, 01 Mar 2006 09:55:05 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: [ANNOUNCE] quilt2git v0.2
References: <20060228111115.GA32276@htj.dyndns.org>
In-Reply-To: <20060228111115.GA32276@htj.dyndns.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Hello, v0.2 of quilt2git available.  New in v0.2.
> 
> * handles new git HEAD file format properly (regular file storing ref: ...)
> 
> * makes use of mail format header from quilt patch description.  From:
>   becomes the author, Subject: the subject of the patch.  All commit
>   information should be maintained through git2quilt -> quilt2git now.
> 
> * --signoff option added.  This option is simply passed to git-commit.
> 
> * little fixes
> 
> http://home-tj.org/wiki/index.php/Misc
> http://home-tj.org/files/misc/quilt2git-0.2
> http://home-tj.org/files/misc/git2quilt-0.1
> 
> Thanks.
> 

FWIW, I have a similar script to import a quilt export as an stgit patch 
series, it's really simple but quite useful:

   http://vserver.ustl.gen.nz/scripts/import-quilt

Sam.
