Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWDMQLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWDMQLI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 12:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWDMQLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 12:11:08 -0400
Received: from pproxy.gmail.com ([64.233.166.180]:58647 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750953AbWDMQLH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 12:11:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TW8KPIhcTwWGvToQKQ7CVDRH8E9Y+ze1+UPF3e7Ao+zUk+kXVm3IzRz6XOekZPTg5N9L0mkv430q5fT9gXyXaTMslI/VK9O9Y7gc9tSJQ7IYIEj3oRBAKMz93EZ+yCL+bVbmM5tWu4iR1DnubOz7Doktu54hMxlu4Hw6bGes5vc=
Message-ID: <728201270604130911y4adf9967kd38712e731161074@mail.gmail.com>
Date: Thu, 13 Apr 2006 11:11:06 -0500
From: "Ram Gupta" <ram.gupta5@gmail.com>
To: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>
Subject: Re: select takes too much time
Cc: "linux mailing-list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060413153028.GA26480@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <728201270604130801l377d7285y531133ee9ee56e8c@mail.gmail.com>
	 <20060413153028.GA26480@rhlx01.fht-esslingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/06, Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> Hi,
>


>
> Now if you have issues with select() taking too long, then I'd say tough
> luck, that's life, other processes seem more important than y
>
> Or, to put it differently, select() doesn't have realtime guarantees, i.e.
> there's no way for you to boldly assume that once select() times out
> your process will continue to run instantly within microseconds.

I was not expecting it to run instantly within microseconds but 1
second seemed to me too much
