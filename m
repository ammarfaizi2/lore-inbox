Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSFEKO1>; Wed, 5 Jun 2002 06:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSFEKO0>; Wed, 5 Jun 2002 06:14:26 -0400
Received: from ns.suse.de ([213.95.15.193]:41743 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S314396AbSFEKOX>;
	Wed, 5 Jun 2002 06:14:23 -0400
Date: Wed, 5 Jun 2002 12:14:20 +0200
From: Dave Jones <davej@suse.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.20 config forward references to CONFIG_X86_LOCAL_APIC
Message-ID: <20020605121420.F5277@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <21732.1023252941@kao2.melbourne.sgi.com> <Pine.LNX.4.44.0206051002210.26634-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 10:07:15AM +0200, Zwane Mwaikambo wrote:
 > > The forward references result in incorrect configurations when
 > > switching config from one cpu type to another or from SMP to UP.
 > We could move the conditional to preprocessor time by wrapping certain 
 > bits in #ifdef (urgh), what really is the more elegant way of doing it?

Doing the CONFIG_X86_LOCAL_APIC definition earlier.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
