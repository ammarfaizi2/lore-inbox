Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbUARQCE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 11:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUARQCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 11:02:04 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:49294 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S261881AbUARQCB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 11:02:01 -0500
From: Andrew Walrond <andrew@walrond.org>
To: Andreas Haumer <andreas@xss.co.at>, "Yu, Luming" <luming.yu@intel.com>
Subject: Re: ACPI: problem on ASUS PR-DLS533
Date: Sun, 18 Jan 2004 16:01:58 +0000
User-Agent: KMail/1.5.4
Cc: Stephan von Krawczynski <skraw@ithnet.com>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
References: <3ACA40606221794F80A5670F0AF15F8401720CE9@PDSMSX403.ccr.corp.intel.com> <400A7119.7000803@xss.co.at>
In-Reply-To: <400A7119.7000803@xss.co.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401181601.58105.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 Jan 2004 11:42 am, Andreas Haumer wrote:
>
> b) Wait for the vendor to fix the problem in the BIOS.
>    This requires to file a bug report with the vendor first,
>    of course. For this it would be necessary to describe the
>    issue in detail and make clear that it's a BIOS problem
>    and not a Linux problem. And it would be necessary the
>    vendor acknowledges the problem.
>    Alas, in my experience chances are high that any bug report
>    of this kind vanishes in the dungeons of a vendors internal
>    bug report escalation strategy... (Does anyone know a direct
>    technical contact at ASUS?)
>

I've tried contacting ASUS several times with this issue as I have lots of 
their dual P3 and dual Xeon servers, but end up butting a brick wall, so If 
somebody does have a useful Asus contact, please step forward!

It does raise the issue of exactly what we want out of the kernel though. Ie 
should the kernel just not work with all these asus machines when ACPI is 
enabled, or recognise the problem and fall back to the old discovery 
mechanism.

_I_ can get my asus servers working because 1) I read lkml and am aware of the 
issues 2) Can compile a custom kernel 3) Care enough to keep trying until it 
works. But I'm not normal ;)

And of course The Proprietory OS (tm) seems to manage.

How do the major distros cope? Not enable ACPI at all, or do alot of discovery 
during installation and select an appropriate kernel?

Andrew Walrond

