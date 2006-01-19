Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWASJmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWASJmG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWASJmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:42:06 -0500
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:56015 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751393AbWASJmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:42:05 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Andy Chittenden" <AChittenden@bluearc.com>
Subject: Re: Out of Memory: Killed process 16498 (java).
Date: Thu, 19 Jan 2006 20:41:53 +1100
User-Agent: KMail/1.9
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <89E85E0168AD994693B574C80EDB9C2703555F9F@uk-email.terastack.bluearc.com>
In-Reply-To: <89E85E0168AD994693B574C80EDB9C2703555F9F@uk-email.terastack.bluearc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601192041.54254.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 January 2006 20:40, Andy Chittenden wrote:
> > Are you using scsi? Someone just posted what looks to be a
> > scsi slab leak (Re:
> > scsi cmd slab leak? (Was Re: [ck] Anyone been having OOM
> > killer problems
> > lately?) that causes oom kills. Check your slabinfo for a large
> > scsi_cmd_cache.
>
> Not using scsi.  Using ide and sata. The target for the dd command was
> an ide disk.
>
> # cat /proc/slabinfo | grep scsi
> scsi_cmd_cache         4      8    448    8    1 : tunables   54   27
> 0 : slabdata      1      1      0
>
> Is that large?

Heh, absolutely not. It was a shot in the dark anyway. Good luck.

Cheers,
Con
