Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWERJPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWERJPp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 05:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWERJPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 05:15:45 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:61784 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1750978AbWERJPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 05:15:44 -0400
Message-ID: <446C3B3C.1050301@tls.msk.ru>
Date: Thu, 18 May 2006 13:15:40 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] Re: [PATCH 00/22] -stable review
References: <20060517221312.227391000@sous-sol.org> <Pine.LNX.4.64.0605171522050.10823@g5.osdl.org> <20060517223601.GI2697@moss.sous-sol.org> <20060517224124.GA23967@kroah.com>
In-Reply-To: <20060517224124.GA23967@kroah.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, May 17, 2006 at 03:36:01PM -0700, Chris Wright wrote:
>> * Linus Torvalds (torvalds@osdl.org) wrote:
>>>
>>> On Wed, 17 May 2006, Chris Wright wrote:
>>>> This is the start of the stable review cycle for the 2.6.16.17 release.
>>>> There are 22 patches in this series, all will be posted as a response to
>>>> this one.
>>> I notice that none of the patches have authorship information.
>>>
>>> Has that always been true and I just never noticed before?
>> It has always been that way with my script, I think Greg's as well.  Of
>> course, it's in the patch, and goes into git with proper authorship.
> 
> The original versions of the patches do have the proper authorship
> information, it's just that quilt strips it off when generating emails
> like this.
> 
> When applying them to the git tree, everything comes out properly and
> they get the correct authorship information.  And the git tools know to
> properly create the emails with the right From: lines, maybe I should
> play around with quilt to add that to it too...

While we're on it.. Just another small nitpick.  Random patch from this 00/22
series:

 Subject: [PATCH 05/22] [PATCH] smbfs: Fix slab corruption in samba error path

Can the 2nd "[PATCH]" tag be removed as well? ;)

/mjt
