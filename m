Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262690AbUKXQyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbUKXQyo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 11:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbUKXQw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 11:52:59 -0500
Received: from fsmlabs.com ([168.103.115.128]:149 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262645AbUKXQwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 11:52:24 -0500
Date: Wed, 24 Nov 2004 09:52:30 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Nigel Cunningham <ncunningham@linuxmail.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 42/51: Suspend.c
In-Reply-To: <1101299659.5805.367.camel@desktop.cunninghams>
Message-ID: <Pine.LNX.4.61.0411240949020.7171@musoma.fsmlabs.com>
References: <1101292194.5805.180.camel@desktop.cunninghams>
 <1101299659.5805.367.camel@desktop.cunninghams>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2004, Nigel Cunningham wrote:

> Here's the heart of the core :> (No, that's not a typo).
> 
> - Device suspend/resume calls
> - Power down
> - Highest level routine
> - all_settings proc entry handling

This isn't the only patch (the utility.c file is another one) which 
introduces functions/helpers which are subsystem specific (like ACPI) but 
somehow land up in the same file with a suspend_ prefix. I understand that 
it'll be more work but can you get them integrated with the subsystem in 
question?

Thanks,
	Zwane

