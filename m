Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVBHRGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVBHRGO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 12:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVBHRGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 12:06:14 -0500
Received: from av4-2-sn3.vrr.skanova.net ([81.228.9.112]:54741 "EHLO
	av4-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S261574AbVBHRGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 12:06:04 -0500
To: Stephane Raimbault <stephane.raimbault@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Touchpad problems with 2.6.11-rc2
References: <1107860158.5271.12.camel@picasso.lan>
From: Peter Osterlund <petero2@telia.com>
Date: 08 Feb 2005 18:05:56 +0100
In-Reply-To: <1107860158.5271.12.camel@picasso.lan>
Message-ID: <m3oeev3rt7.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Raimbault <stephane.raimbault@free.fr> writes:

> I'm using 2.6.11-rc3 + Peter's patch and xorg from Fedora Core 3, I
> still have touchpad problems.
>  
> Tapping and focus work fine with 2.6.10 and 2.6.11-rc1 but not with :
> - 2.6.11-rc2
> - 2.6.11-rc3
> I read a similar report on LKML from David Ford.
> Only one tap on 30 is received and focus is really strange.
> 
> Like said in previous mails, small movements are rounded off to 0 but
> the Peter Osterlund's patch resolves this problem (tested with rc3).
> 
> Hardware
> kernel: input: AlpsPS/2 ALPS TouchPad on isa0 060/serio1
> Vaio GRT916V
> 
> In my xorg.conf :
> Driver      "mouse"
> Option      "Protocol" "IMPS/2"

Does the "Enable hardware tapping for ALPS touchpads" patch help?

        http://marc.theaimsgroup.com/?l=linux-kernel&m=110708138225873&w=2

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
