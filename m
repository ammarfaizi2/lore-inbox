Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751789AbWCHNEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbWCHNEm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 08:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWCHNEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 08:04:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:36076 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751789AbWCHNEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 08:04:41 -0500
From: Andi Kleen <ak@muc.de>
To: vgoyal@in.ibm.com
Subject: Re: [RFC][PATCH] kdump: x86_64 timer interrupt lockup due to pending interrupt
Date: Wed, 8 Mar 2006 06:31:55 +0100
User-Agent: KMail/1.9.1
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Andrew Morton <akpm@osdl.org>
References: <20060306164034.GB10594@in.ibm.com> <m1hd69zur8.fsf@ebiederm.dsl.xmission.com> <20060308012654.GB25543@in.ibm.com>
In-Reply-To: <20060308012654.GB25543@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603080631.56754.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> o Though today only timer seems to be the special case because in early
>   boot it thinks interrupts are coming from i8259 and uses
>   mask_and_ack_8259A() as ack handler and does not issue LAPIC EOI. But
>   probably doing it in generic manner for all vectors makes sense.

Applied thanks. 

Not sure if this is still 2.6.16 material though. Might be too late for that.

-Andi
