Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318606AbSGSRI4>; Fri, 19 Jul 2002 13:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318607AbSGSRI4>; Fri, 19 Jul 2002 13:08:56 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:19620 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S318606AbSGSRIz> convert rfc822-to-8bit; Fri, 19 Jul 2002 13:08:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH]: scheduler complex macros fixes
Date: Fri, 19 Jul 2002 19:11:48 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@linuxia64.org>,
       Linus Torvalds <torvalds@transmeta.com>
References: <Pine.LNX.4.44.0207201855380.17169-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0207201855380.17169-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207191911.48427.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Saturday 20 July 2002 18:57, Ingo Molnar wrote:
> On Fri, 19 Jul 2002, Erich Focht wrote:
> > The attached patch fixes problems with the "complex" macros in the
> > scheduler, as discussed about a week ago with Ingo on this mailing list.
>
> the fix has been in my tree for some time, the latest version, against
> 2.5.26 is at:
>
>   http://people.redhat.com/mingo/O(1)-scheduler/sched-2.5.26-B7
>
> it has a number of other fixes as well, plus the SCHED_BATCH feature.
>
> 	Ingo

Thanks. But as long as SCHED_BATCH ins't in 2.5.X, we need this separate
fix. And if it's in the main tree, you don't need it additionally in
your patches. The fix is O(1) specific and I thought it should not hide
inside the SCHED_BATCH patches, some people might encounter these
problems...

Regards,
Erich

