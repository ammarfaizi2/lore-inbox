Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWBSX43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWBSX43 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 18:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWBSX43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 18:56:29 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:15629 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932458AbWBSX42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 18:56:28 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: No sound from SB live!
Date: Sun, 19 Feb 2006 23:56:39 +0000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Nick Warne <nick@linicks.net>, Jesper Juhl <jesper.juhl@gmail.com>,
       tiwai@suse.de, ghrt@dial.kappa.ro, perex@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>
References: <20060218231419.GA3219@elf.ucw.cz> <200602192323.08169.s0348365@sms.ed.ac.uk> <1140391929.2733.430.camel@mindpipe>
In-Reply-To: <1140391929.2733.430.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602192356.39834.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 February 2006 23:32, Lee Revell wrote:
> On Sun, 2006-02-19 at 23:23 +0000, Alistair John Strachan wrote:
> > I'm still using 1.0.9 on 2.6.16-rc4 with no problems, Audigy 2 (one
> > that uses
> > emu10k1).
>
> It's a specific change to the SBLive! that did not affect the Audigy
> that causes alsa-lib 1.0.10+ to be required on 2.6.14 and up.  These
> types of incompatible changes should be rare.
>
> It was a necessary precursor to fixing the well known "master volume
> only controls front speakers" bug.

Thanks for this info Lee, and understand I don't hold anybody specifically in 
the alsa team responsible but *deep breath*:

Please let everybody know about incompatible changes to alsa-lib know about it 
prior to making the change mandatory.

This means immediately update http://www.alsa-project.org/ with the 
information. I do not mean add a one-liner to the changelog.

ALSA's great and I wholeheartedly support it, but this sort of thing cannot 
happen without informing people about the requirement. Expecting people to 
"just upgrade" is frankly not acceptable. At all. We're not using Rawhide.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
