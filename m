Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283057AbRLDLFH>; Tue, 4 Dec 2001 06:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283059AbRLDLE5>; Tue, 4 Dec 2001 06:04:57 -0500
Received: from t2.redhat.com ([199.183.24.243]:55796 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S283057AbRLDLEj>; Tue, 4 Dec 2001 06:04:39 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011202201946.A7662@thyrsus.com> 
In-Reply-To: <20011202201946.A7662@thyrsus.com>  <1861.1007341572@kao2.melbourne.sgi.com> 
To: esr@thyrsus.com
Cc: Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 04 Dec 2001 11:04:19 +0000
Message-ID: <10297.1007463859@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
>  The schedule I heard from Linus at the kernel summit was that both
> changes  were to go in between 2.5.1 and 2.5.2.   I would prefer
> sooner than later  because I'm *really* *tired* of maintaining a
> parallel rulebase.

Is it not possible to write an automatic conversion tool that reads the 
existing CML1 files and outputs CML2 rules with identical behaviour?

After all, the only way for the merge of CML2 to be acceptable is to merge
the tools _first_, without changing the resulting behaviour of the config
rules, and then to make behavioural changes in later versions.

--
dwmw2


