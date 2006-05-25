Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbWEYSx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbWEYSx4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 14:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWEYSx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 14:53:56 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.7]:5132 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1030332AbWEYSxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 14:53:55 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add compile domain (was: Re: [PATCH] Well, Linus seems to like Lordi...)
Date: Thu, 25 May 2006 19:54:06 +0100
User-Agent: KMail/1.9.1
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Kyle McMartin <kyle@mcmartin.ca>,
       linux-kernel@vger.kernel.org
References: <20060525141714.GA31604@skunkworks.cabal.ca> <Pine.LNX.4.61.0605252027380.13379@yvahk01.tjqt.qr> <Pine.LNX.4.64.0605251146260.5623@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605251146260.5623@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605251954.06227.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 May 2006 19:47, Linus Torvalds wrote:
> On Thu, 25 May 2006, Jan Engelhardt wrote:
> > # hostname --fqdn
> > shanghai.hopto.org
>
> Ahh. I wonder how portable this is. We could certainly make the kernel
> build use "hostname --fqdn" if that works across all versions.
>
> That code hasn't changed in a looong time, and I suspect that "--fqdn"
> didn't exist back when..

This is probably a broken configuration, but it would cause a regression for 
me:

[alistair] 19:53 [~] hostname
damocles

[alistair] 19:52 [~] hostname --fqdn
localhost

"localhost" isn't very descriptive if I'm trying to figure out which machine a 
dmesg came from.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
