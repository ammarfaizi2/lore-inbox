Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbTJAOS3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbTJAOS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:18:29 -0400
Received: from lidskialf.net ([62.3.233.115]:31183 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S262201AbTJAOSZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:18:25 -0400
From: Andrew de Quincey <adq@lidskialf.net>
To: Sven =?iso-8859-1?q?K=F6hler?= <skoehler@upb.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [ACPI] p2b-ds blacklisted?
Date: Wed, 1 Oct 2003 15:16:45 +0100
User-Agent: KMail/1.5.3
References: <blen4v$a42$1@sea.gmane.org>
In-Reply-To: <blen4v$a42$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200310011516.45878.adq@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 Oct 2003 3:07 pm, Sven Köhler wrote:
> Hi,
>
> my P2B-DS is blacklisted and the kernel forced acpi=ht. i wonder why
> because P2B-D is not blacklisted.
>
> There is no comment or any other hint for a reason in dmi_scan.c :-(
>
> I would like to try what happens if i remove the board from the
> blacklist. What can i test to see if it works properly? And what is the
> worse case of what could happen?
>
> Do i have to edit dmi_scan.c for my test or is there something like
> acpi=force?

I'm sure I saw a comment somewhere saying the P2B-S was blacklisted because of 
"bogus IRQ routing". It was in the blacklisting code, but I can't remember 
where, or if it was 2.4 or 2.6.

