Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWHVID1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWHVID1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWHVID0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:03:26 -0400
Received: from ns1.suse.de ([195.135.220.2]:10649 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751275AbWHVIDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:03:25 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH][RFC] x86_64: Reload CS when startup_64 is used.
Date: Tue, 22 Aug 2006 10:03:12 +0200
User-Agent: KMail/1.9.3
Cc: Magnus Damm <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
References: <20060821095328.3132.40575.sendpatchset@cherry.local> <1156208306.21411.85.camel@localhost> <m1u045sagu.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1u045sagu.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608221003.12608.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So if we never reload %cs and only use the shadow values why does 
> the value in %cs matter?

We usually do at the first IRET.

-Andi
