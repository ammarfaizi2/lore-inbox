Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751926AbWGAUM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbWGAUM5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 16:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbWGAUM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 16:12:57 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:13838 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1751926AbWGAUM4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 16:12:56 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Dave Jones <davej@redhat.com>
Subject: Re: Eeek! page_mapcount(page) went negative! (-1)
Date: Sat, 1 Jul 2006 21:13:23 +0100
User-Agent: KMail/1.9.3
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Daniel Drake <dsd@gentoo.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
References: <44A6AB99.8060407@gentoo.org> <44A6B11B.9080204@yahoo.com.au> <20060701180930.GE15810@redhat.com>
In-Reply-To: <20060701180930.GE15810@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607012113.23053.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 July 2006 19:09, Dave Jones wrote:
> On Sun, Jul 02, 2006 at 03:30:03AM +1000, Nick Piggin wrote:
>  > Oh. I see Arjan's pointed out it is using the nvidia driver (how
>  > did he figure that out?).
>
> intuition. The process was X, and there have been reports of
> the nvidia driver triggering this in Fedora bugzilla as well
> as other places.

Also if you check the original bug report, there's video_cards_nvidia in the 
USE flags, which I think includes nvidia-glx (proprietary code).

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
