Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280960AbRLDQzo>; Tue, 4 Dec 2001 11:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281463AbRLDQyX>; Tue, 4 Dec 2001 11:54:23 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:18824 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S281297AbRLDQyC>;
	Tue, 4 Dec 2001 11:54:02 -0500
Message-ID: <3C0CFF5F.3090404@dplanet.ch>
Date: Tue, 04 Dec 2001 17:52:47 +0100
From: Giacomo Catenazzi <cate@dplanet.ch>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: esr@thyrsus.com, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
In-Reply-To: <20011204111115.A15160@thyrsus.com>  <1861.1007341572@kao2.melbourne.sgi.com> <20011204131136.B6051@caldera.de> <20011204072808.A11867@thyrsus.com> <20011204133932.A8805@caldera.de> <20011204074815.A12231@thyrsus.com> <20011204140050.A10691@caldera.de> <20011204081640.A12658@thyrsus.com> <20011204142958.A14069@caldera.de> <19642.1007484062@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Dec 2001 16:54:00.0903 (UTC) FILETIME=[45D48D70:01C17CE4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:

> 
> I do have objections to some of the other ideas which have been floated for
> changing the behaviour of the config rules, which aren't strictly related to
> the change in language. 


The rules are nearly the same (but written in another language).
The problem was in converting rules: esr found a lot of error:
these error should be corrected, also some rules are different.

Also converting rules, you surelly found some error: i.e. wrong
dependencies syntax, wrong implementation,....

I don't think esr changed non problematic rules, but one:
all rules without help become automatically dependent to
CONFIG_EXPERIMENTAL. I don't like it, but I understand why
he makes this decision.

Remember: The config.in files contain a lot of errors, and
automatic tools can not find all.

	giacomo

