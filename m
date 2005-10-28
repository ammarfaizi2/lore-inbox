Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVJ1UUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVJ1UUF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 16:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVJ1UUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 16:20:05 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:28611 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1750723AbVJ1UUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 16:20:01 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Nathan Scott <nathans@sgi.com>
Subject: Re: What happened to XFS Quota Support?
Date: Fri, 28 Oct 2005 21:18:45 +0100
User-Agent: KMail/1.8.92
Cc: AndyLiebman@aol.com, linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
References: <190.4ba4a2cb.3093d02a@aol.com> <20051029054618.A6139565@wobbly.melbourne.sgi.com>
In-Reply-To: <20051029054618.A6139565@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510282118.45167.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 October 2005 20:46, Nathan Scott wrote:
> Hi Andy,
>
> On Fri, Oct 28, 2005 at 03:04:10PM -0400, AndyLiebman@aol.com wrote:
> > ...
> > Is there a reason why this option is no longer available? If you compile
> > xfs_quota as a module, how do you load it?
>
> Oh, bother - the option:
>
> config XFS_QUOTA
>         tristate "XFS Quota support"
>
> should be:
>
> config XFS_QUOTA
> 	bool "XFS Quota support"
>
> I'll get that fixed up, thanks.

This might be a good thing to put in 2.6.14.1.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
