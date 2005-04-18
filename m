Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVDRISq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVDRISq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 04:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVDRISq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 04:18:46 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:37839 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261896AbVDRISp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 04:18:45 -0400
To: Paul Jackson <pj@sgi.com>
Cc: torvalds@osdl.org, jgarzik@pobox.com, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com,
       dwmw2@infradead.org
Subject: Re: New SCM and commit list
References: <1113174621.9517.509.camel@gaston>
	<Pine.LNX.4.58.0504101621200.1267@ppc970.osdl.org>
	<425A10EA.7030607@pobox.com>
	<Pine.LNX.4.58.0504102304050.1267@ppc970.osdl.org>
	<tnx64ys8gq1.fsf@arm.com> <20050416013541.2e6f6c60.pj@sgi.com>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 18 Apr 2005 09:18:16 +0100
In-Reply-To: <20050416013541.2e6f6c60.pj@sgi.com> (Paul Jackson's message of
 "Sat, 16 Apr 2005 01:35:41 -0700")
Message-ID: <tnxis2ka46v.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>> "merge" does a better job than "diff3" since it can resolve the
>
> The merge command I know of is part of Tichy's RCS tools,
> and calls diff3, and has no inherent superior abilities.

You are right, I missed some diff3 options. It looks like "diff3 -mE"
generates the same output as "merge" (i.e. solving the identical
changes in the derived files). Sorry for the noise :-)

-- 
Catalin

