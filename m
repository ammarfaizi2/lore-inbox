Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUIEL1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUIEL1E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 07:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266351AbUIEL1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 07:27:04 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39384 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266304AbUIEL1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 07:27:02 -0400
Date: Sun, 5 Sep 2004 13:28:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm3 (ACPI broken)
Message-ID: <20040905112826.GA9269@elte.hu>
References: <397530000.1094223829@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <397530000.1094223829@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Martin J. Bligh <mbligh@aracnet.com> wrote:

> Something is still borked - looks very much like ACPI still, but not
> the same bug. Backing out the force-ons out of mm2 fixed it ... so
> it's something else other than just the config.

these build problems simply pop up if one disables CONFIG_ACPI. This is
a recent breakage, 2.6.8.1-mm didnt show it.

	Ingo
