Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbVIIIuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbVIIIuz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbVIIIuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:50:54 -0400
Received: from mx1.suse.de ([195.135.220.2]:22926 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965096AbVIIIuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:50:54 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [PATCH] fix x86-64 interrupt re-enabling in oops_end()
Date: Fri, 9 Sep 2005 10:45:19 +0200
User-Agent: KMail/1.8
Cc: "Jan Beulich" <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <43207E680200007800024547@emea1-mh.id2.novell.com>
In-Reply-To: <43207E680200007800024547@emea1-mh.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509091045.20104.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 September 2005 18:09, Jan Beulich wrote:
> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)
>
> Rather than blindly re-enabling interrupts in oops_end(), save their
> state
> in oope_begin() and then restore that state.


Thanks queued. Please don't do that many white space only changes
next time.

-Andi
