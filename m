Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUCKOSF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 09:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUCKOSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 09:18:05 -0500
Received: from main.gmane.org ([80.91.224.249]:21896 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261347AbUCKOSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 09:18:03 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Mike Hearn <mh@codeweavers.com>
Subject: Re: [PATCH] binfmt_elf.c allow .bss with no access (p---)
Date: Thu, 11 Mar 2004 14:23:07 +0000
Organization: CodeWeavers, Inc
Message-ID: <pan.2004.03.11.14.23.07.585954@codeweavers.com>
References: <1078508281.3065.33.camel@linux.littlegreen> <404A1C71.3010507@redhat.com> <1078607410.10313.7.camel@linux.littlegreen> <m1brn8us96.fsf@ebiederm.dsl.xmission.com> <404C0B57.6030607@BitWagon.com> <20040308080615.GS31589@devserv.devel.redhat.com> <4050047F.5010808@BitWagon.com>
Reply-To: mike@theoretic.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: e-ucs036.dur.ac.uk
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004 22:17:35 -0800, John Reiser wrote:
> This ALPHA quality patch against 2.6.3 adds another argument to do_brk()
> which enables having a user ELF .bss with no-access (or read-only).

Hi,

Does this fix the Wine case where we have a new RO section that isn't the
BSS?

thanks -mike

