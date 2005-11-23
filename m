Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030500AbVKWXiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030500AbVKWXiu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbVKWXiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:38:50 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:42935 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1030500AbVKWXis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:38:48 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: Kernel BUG at mm/rmap.c:491
Date: Wed, 23 Nov 2005 23:38:54 +0000
User-Agent: KMail/1.9
Cc: Kenneth W <kenneth.w.chen@intel.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
References: <200511232333.jANNX9g23967@unix-os.sc.intel.com> <cone.1132788946.360368.25446.501@kolivas.org>
In-Reply-To: <cone.1132788946.360368.25446.501@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511232338.54794.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 November 2005 23:35, Con Kolivas wrote:
> Chen, Kenneth W writes:
> > Con Kolivas wrote on Wednesday, November 23, 2005 3:24 PM
> >
> >> Chen, Kenneth W writes:
> >> > Has people seen this BUG_ON before?  On 2.6.15-rc2, x86-64.
> >> >
> >> > Pid: 16500, comm: cc1 Tainted: G    B 2.6.15-rc2 #3
> >> >
> >> > Pid: 16651, comm: sh Tainted: G    B 2.6.15-rc2 #3
> >>
> >>                        ^^^^^^^^^^
> >>
> >> Please try to reproduce it without proprietary binary modules linked in.
> >
> > ???, I'm not using any modules at all.
> >
> > [albat]$ /sbin/lsmod
> > Module                  Size  Used by
> > [albat]$
> >
> >
> > Also, isn't it 'P' indicate proprietary module, not 'G'?
> > line 159: kernel/panic.c:
> >
> >         snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c%c%c",
> >                 tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',
>
> Sorry it's not proprietary module indeed. But what is tainting it?

Probably a prior oops or some other marked error condition.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
