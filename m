Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262865AbUKXVhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbUKXVhJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 16:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbUKXVet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 16:34:49 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:53915 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262778AbUKXVdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 16:33:47 -0500
Subject: Re: Suspend 2 merge: 42/51: Suspend.c
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0411240949020.7171@musoma.fsmlabs.com>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101299659.5805.367.camel@desktop.cunninghams>
	 <Pine.LNX.4.61.0411240949020.7171@musoma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1101331403.3895.42.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 08:23:23 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-25 at 03:52, Zwane Mwaikambo wrote:
> On Thu, 25 Nov 2004, Nigel Cunningham wrote:
> 
> > Here's the heart of the core :> (No, that's not a typo).
> > 
> > - Device suspend/resume calls
> > - Power down
> > - Highest level routine
> > - all_settings proc entry handling
> 
> This isn't the only patch (the utility.c file is another one) which 
> introduces functions/helpers which are subsystem specific (like ACPI) but 
> somehow land up in the same file with a suspend_ prefix. I understand that 
> it'll be more work but can you get them integrated with the subsystem in 
> question?

Okee doke. I've thought about separating some of those debugging
specific functions out into their own file too.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

