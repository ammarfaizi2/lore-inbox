Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTILSAE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbTILSAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:00:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49559 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261798AbTILR76
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 13:59:58 -0400
Message-ID: <3F62098F.9030300@pobox.com>
Date: Fri, 12 Sep 2003 13:59:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, akpm@osdl.org,
       richard.brunner@amd.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com>	<20030911012708.GD3134@wotan.suse.de>	<20030910184414.7850be57.akpm@osdl.org>	<20030911014716.GG3134@wotan.suse.de>	<3F60837D.7000209@pobox.com>	<20030911162634.64438c7d.ak@suse.de>	<3F6087FC.7090508@pobox.com>	<m1vfrxlxol.fsf@ebiederm.dsl.xmission.com> <20030912195606.24e73086.ak@suse.de>
In-Reply-To: <20030912195606.24e73086.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> The main reason I'm really against this is that currently the P4 kernels work
> fine on Athlon. Just when is_prefetch is not integrated in them there will 
> be an mysterious oops once every three months in the kernel in prefetch
> on Athlon.


Booting a P4 kernel _without_ CONFIG_X86_GENERIC on an Athlon would be a 
user bug.

	Jeff



