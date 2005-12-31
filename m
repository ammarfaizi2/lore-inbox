Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbVLaSr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbVLaSr3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 13:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbVLaSr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 13:47:29 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:38591 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S965034AbVLaSr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 13:47:28 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Bradley Reed <bradreed1@gmail.com>
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
Date: Sat, 31 Dec 2005 18:47:48 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <20051231202933.4f48acab@galactus.example.org>
In-Reply-To: <20051231202933.4f48acab@galactus.example.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512311847.48296.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 December 2005 18:29, Bradley Reed wrote:
> I have tried MPlayer versions 1.0pre6, 1.0pre7, and cvs from today and
> they all work fine under 2.6.14 and 2.6.14-rt21/22.
>
> I booted into 2.6.15-rc7-rt1 and the same MPlayer binaries segfault on
> every video I try and play. Yes, I have nvidia modules loaded, so won't
> get much help, but thought someone might like to know.
>
> xine plays the videos fine.
>
> BTW, other than MPLayer problems, everything else works great.
>
> Brad

Try mplayer -nortc? If that work's it'll confirm the problem is with opening 
the rtc device.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
