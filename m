Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVIBSJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVIBSJl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 14:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVIBSJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 14:09:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36294 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750761AbVIBSJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 14:09:40 -0400
Subject: Re: IDE HPA
From: Peter Jones <pjones@redhat.com>
Reply-To: pjones@redhat.com
To: "ATARAID (eg, Promise Fasttrak, Highpoint 370) related discussions" 
	<ataraid-list@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <62b0912f05090210441d3fa248@mail.gmail.com>
References: <87941b4c05082913101e15ddda@mail.gmail.com>
	 <87941b4c05083008523cddbb2a@mail.gmail.com>
	 <1125419927.8276.32.camel@localhost.localdomain>
	 <87941b4c050830095111bf484e@mail.gmail.com>
	 <62b0912f0509020027212e6c42@mail.gmail.com>
	 <1125666332.30867.10.camel@localhost.localdomain>
	 <62b0912f05090206331d04afd3@mail.gmail.com>
	 <E1EBCdS-00064p-00@chiark.greenend.org.uk>
	 <62b0912f05090209242ad72321@mail.gmail.com>
	 <1125680712.30867.20.camel@localhost.localdomain>
	 <62b0912f05090210441d3fa248@mail.gmail.com>
Content-Type: text/plain
Organization: Red Hat, Inc.
Date: Fri, 02 Sep 2005 14:09:27 -0400
Message-Id: <1125684567.31292.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 (2.3.8-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-02 at 19:44 +0200, Molle Bestefich wrote:

> Related matters:
> If you decide to include the HPA in one of your filesystems, is there
> not a big risk that the BIOS will overwrite something there?

Isn't the bigger risk that if you include the HPA in your block device,
you'll overwrite your BIOS there?

At least that's what happens on some thinkpads.

It'd be nice if we left it as the BIOS leaves it by default, but make a
straightforward way to enable/disable/alter the HPA region from
software.

(if there's already a straightforward way, feel free to clue me in --
but the default should almost certainly be to assume the HPA is set up
correctly, shouldn't it?)
-- 
  Peter

