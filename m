Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbVLGPHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbVLGPHF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVLGPHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:07:05 -0500
Received: from mail.di.fct.unl.pt ([193.136.122.1]:4272 "EHLO ns.di.fct.unl.pt")
	by vger.kernel.org with ESMTP id S1751130AbVLGPHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:07:04 -0500
From: Marco Correia <mvc@di.fct.unl.pt>
Organization: DI - FCT/UNL
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: slow boot
Date: Wed, 7 Dec 2005 15:06:40 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <200512071027.26364.mvc@di.fct.unl.pt> <84144f020512070701s344f721dsd92f33d5f275a453@mail.gmail.com>
In-Reply-To: <84144f020512070701s344f721dsd92f33d5f275a453@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512071506.40336.mvc@di.fct.unl.pt>
X-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday 07 December 2005 15:01, Pekka Enberg wrote:
> Hi Marco,
>
> On 12/7/05, Marco Correia <mvc@di.fct.unl.pt> wrote:
> > I've been experiencing very VERY slow boots after I've upgraded from
> > kernel 2.6.10 to 2.6.14.2. The boot process is fast until the start of
> > the init script, after this 2.6.14.2 spends 10 seconds or so for each
> > init task.
>
> It would be helpful if you could identify the exact version where this
> regression happened. If you're comfortable with git, please refer to
> the following document on how to isolate the changeset that causes the
> problem:
> http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with-bis
>ect.txt
>
>                                     Pekka

Hi,

Thanks for the reply. I think my problem has something to do with this 
http://bugzilla.kernel.org/show_bug.cgi?id=5165, however I just installed 
kernel 2.6.15_rc5 and the problem is still there, but now it seems that it 
slows down even before the init begins.

As soon as I have the time I'll look into git, since I never used it before. 

Thanks again
Marco
-- 
Marco Correia <mvc@di.fct.unl.pt>
