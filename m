Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266736AbTCEMQn>; Wed, 5 Mar 2003 07:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266755AbTCEMQn>; Wed, 5 Mar 2003 07:16:43 -0500
Received: from holomorphy.com ([66.224.33.161]:24477 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266736AbTCEMQn>;
	Wed, 5 Mar 2003 07:16:43 -0500
Date: Wed, 5 Mar 2003 04:26:54 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Reed, Timothy A" <timothy.a.reed@lmco.com>
Cc: "Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: High Mem Options
Message-ID: <20030305122654.GR1195@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Reed, Timothy A" <timothy.a.reed@lmco.com>,
	"Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>
References: <9EFD49E2FB59D411AABA0008C7E675C00DCDFE01@emss04m10.ems.lmco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9EFD49E2FB59D411AABA0008C7E675C00DCDFE01@emss04m10.ems.lmco.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 06:28:36AM -0500, Reed, Timothy A wrote:
> 	Yet another quick question...is there any down side to using the
> 64GB option over the 4GB option if the machine only has 2GB of RAM onboard??
> I would think this would be a performance issue?  Does the kernel only use
> the translation table if it has to access any memory location over 4GB?

Yes, the additional level of pagetables slows things down quite a bit.


-- wli
