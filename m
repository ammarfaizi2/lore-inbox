Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267543AbUIYMHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267543AbUIYMHP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 08:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269192AbUIYMHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 08:07:15 -0400
Received: from lucidpixels.com ([66.45.37.187]:32640 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S267543AbUIYMHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 08:07:14 -0400
Date: Sat, 25 Sep 2004 08:07:04 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Reproducable DoS with NFS+XFS under 2.6.{5,8.1}
In-Reply-To: <20040925125351.A4473@infradead.org>
Message-ID: <Pine.LNX.4.61.0409250807000.3907@p500>
References: <Pine.LNX.4.61.0409250642050.19470@p500> <20040925125351.A4473@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, thanks.

On Sat, 25 Sep 2004, Christoph Hellwig wrote:

> On Sat, Sep 25, 2004 at 06:45:36AM -0400, Justin Piszcz wrote:
>> Two issues.
>>
>> 1 - With 2.6.5
>> 2 - With 2.6.8.1
>>
>> 1 - I have the actual oops.
>> 2 - Reproducable every time I do it but I'd have to copy the panic off the
>>      screen which isn't entirely there.
>>
>>
>> Problem 1: If you try to copy a file off of an NFS share while it is being
>> written:
>
> This should be fixed in XFS cvs at oss.sgi.com, and will be merged to
> mainline soon.
>
