Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424428AbWKJUMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424428AbWKJUMs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 15:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424426AbWKJUMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 15:12:47 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31666 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1424423AbWKJUMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 15:12:46 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: "Andi Kleen" <ak@suse.de>, "Olivier Nicolas" <olivn@trollprod.org>,
       "Andrew Morton" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>,
       "Stephen Hemminger" <shemminger@osdl.org>,
       "Takashi Iwai" <tiwai@suse.de>, "Jaroslav Kysela" <perex@suse.cz>,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com,
       linux-acpi@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: 2.6.19-rc5 x86_64 irq 22: nobody cared
References: <5986589C150B2F49A46483AC44C7BCA49071D9@ssvlexmb2.amd.com>
Date: Fri, 10 Nov 2006 13:11:28 -0700
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA49071D9@ssvlexmb2.amd.com>
	(Yinghai Lu's message of "Fri, 10 Nov 2006 10:20:58 -0800")
Message-ID: <m1u017hxjj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lu, Yinghai" <yinghai.lu@amd.com> writes:

> Andi,
>
> The two patches solve the problems that irq nobody care.
>
> They are already in your tree. But first one I wonder if you put correct
> one in your tree.

YH.  This is a completely different problem.  The irq is properly setup
and received but none of the drivers wanted it.

Eric
