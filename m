Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270234AbTHQNnj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 09:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270243AbTHQNnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 09:43:39 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:29669
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270234AbTHQNng convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 09:43:36 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Daniel Phillips <phillips@arcor.de>,
       mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns?=
	=?iso-8859-1?q?=20Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: [BUG]  Serious scheduler starvation
Date: Sun, 17 Aug 2003 23:49:56 +1000
User-Agent: KMail/1.5.3
References: <yw1xekzkv5yv.fsf@users.sourceforge.net> <200308172252.52464.kernel@kolivas.org> <200308171543.43533.phillips@arcor.de>
In-Reply-To: <200308171543.43533.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308172349.56628.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Aug 2003 23:43, Daniel Phillips wrote:
> On Sunday 17 August 2003 14:52, Con Kolivas wrote:
> > On Sun, 17 Aug 2003 22:11, Måns Rullgård wrote:
> > > First the machine details.  It's a Pentium4 running at 2 GHz.  Linux
> > > version 2.6.0-test3 + O16int + softrr.
> >
> > Softrr ? Which patch? Davide's? Noone has tried to make them compatible
> > (yet?). Even so, this may be unrelated to softrr.
>
> Almost certainly unrelated, since there is no effect unless he runs
> SCHED_RR applications as non-root.
>
> Obviously, he should back the patches out one by one when he does get time
> to reboot.

No need, there is a known issue in my patches that can cause it. Check the 
email I just sent about a similar issue.

Con

