Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030564AbVKXHuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030564AbVKXHuk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 02:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbVKXHuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 02:50:40 -0500
Received: from gold.veritas.com ([143.127.12.110]:6996 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1030564AbVKXHuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 02:50:39 -0500
Date: Thu, 24 Nov 2005 07:50:49 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Dave Jones <davej@redhat.com>
cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Con Kolivas <con@kolivas.org>, Kenneth W <kenneth.w.chen@intel.com>,
       Keith Owens <kaos@sgi.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at mm/rmap.c:491
In-Reply-To: <20051124044009.GE30849@redhat.com>
Message-ID: <Pine.LNX.4.61.0511240747590.5688@goblin.wat.veritas.com>
References: <200511232256.jANMuGg20547@unix-os.sc.intel.com>
 <cone.1132788250.534735.25446.501@kolivas.org> <200511232335.15050.s0348365@sms.ed.ac.uk>
 <20051124044009.GE30849@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Nov 2005 07:50:39.0443 (UTC) FILETIME=[C33BCA30:01C5F0CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Dave Jones wrote:
> On Wed, Nov 23, 2005 at 11:35:15PM +0000, Alistair John Strachan wrote:
>  > On Wednesday 23 November 2005 23:24, Con Kolivas wrote:
>  > > Chen, Kenneth W writes:
>  > > > Has people seen this BUG_ON before?  On 2.6.15-rc2, x86-64.
>  > > >
>  > > > Pid: 16500, comm: cc1 Tainted: G    B 2.6.15-rc2 #3
>  > > >
>  > > > Pid: 16651, comm: sh Tainted: G    B 2.6.15-rc2 #3
>  > >
>  > >                        ^^^^^^^^^^
>  > >
>  > > Please try to reproduce it without proprietary binary modules linked in.
>  > 
>  > AFAIK "G" means all loaded modules are GPL, P is for proprietary modules.
> 
> The 'G' seems to confuse a hell of a lot of people.
> (I've been asked about it when people got machine checks a lot over
>  the last few months).
> 
> Would anyone object to changing it to conform to the style of
> the other taint flags ? Ie, change it to ' ' ?

Please, please do: it's insane as is.  But I've CC'ed Keith,
we sometimes find the kernel does things so to suit ksymoops.

Hugh
