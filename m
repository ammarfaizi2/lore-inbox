Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267096AbSLRBqy>; Tue, 17 Dec 2002 20:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267097AbSLRBqx>; Tue, 17 Dec 2002 20:46:53 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:30393
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S267096AbSLRBqx>; Tue, 17 Dec 2002 20:46:53 -0500
Message-ID: <3DFFD55E.6020305@redhat.com>
Date: Tue, 17 Dec 2002 17:54:38 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021216
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Nakajima, Jun" <jun.nakajima@intel.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
References: <3014AAAC8E0930438FD38EBF6DCEB564419C95@fmsmsx407.fm.intel.com>
In-Reply-To: <3014AAAC8E0930438FD38EBF6DCEB564419C95@fmsmsx407.fm.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nakajima, Jun wrote:
> AMD (at least Athlon, as far as I know) supports sysenter/sysexit. We tested it on an Athlon box as well, and it worked fine. And sysenter/sysexit was better than int/iret too (about 40% faster) there. 

That's good to know but not what I meant.

I referred to syscall/sysret opcodes.  They are broken in their own way
(destroying ecx on kernel entry) but at least they preserve eip.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

