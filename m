Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVC2BRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVC2BRu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 20:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVC2BRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 20:17:50 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:484 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S262136AbVC2BRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 20:17:46 -0500
Message-ID: <4248AC8E.6070604@tlinx.org>
Date: Mon, 28 Mar 2005 17:17:02 -0800
From: "L. A. Walsh" <law@tlinx.org>
Organization: Tlinx Solutions
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, Jean Delvare <khali@linux-fr.org>,
       linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] typo fix in Documentation/eisa.txt
References: <200503271554.44382.eike-kernel@sf-tec.de> <200503272145.10266.eike-kernel@sf-tec.de> <42470E99.7010304@osdl.org> <200503272201.36092.eike-kernel@sf-tec.de>
In-Reply-To: <200503272201.36092.eike-kernel@sf-tec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rolf Eike Beer wrote:

>Typo fixes.
>
>Thanks to Randy Dunlap and Jean Delvare.
>
>Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
>
>--- linux-2.6.11/Documentation/eisa.txt	2005-03-02 08:38:12.000000000 +0100
>+++ linux-2.6.12-rc1/Documentation/eisa.txt	2005-03-27 21:58:04.000000000 +0200
>@@ -171,9 +171,9 @@
> virtual_root.force_probe :
> 
> Force the probing code to probe EISA slots even when it cannot find an
>-EISA compliant mainboard (nothing appears on slot 0). Defaultd to 0
>-(don't force), and set to 1 (force probing) when either
>-CONFIG_ALPHA_JENSEN or CONFIG_EISA_VLB_PRIMING are set.
>+EISA compliant mainboard (nothing appears on slot 0). Defaults to 0
>+(don't force) and set to 1 (force probing) when either
>+CONFIG_ALPHA_JENSEN or CONFIG_EISA_VLB_PRIMING is set.
>
---
01234567890123456789012345678901234567890123456789012345678901234567890123456789
    My expertise is limited by a fuzzy memory, and I know it's bad form to
comment much on english usage or spelling as they are often tangential to
the issue at hand, but as long as we are on the topic, I think you had it
right the first time.

    I believe the comment, properly used the "imperative":
declaring intended usage of the variable, i.e. - "Do this or do
that"; "Default to 0 or set to 1".  To use a perl like example:

                       # set probe action:
probe=0;               # default to 0 (don't force)
probe=1 if (X || Y);   # and set to 1 (force), if either X or Y is set

    If you use "Defaults", then I think that's an implied 3rd person
singular usage and for correct parallelism, the parallel clause (after
the "and") should use the same tense.  Third person tense for "set"
would use "is" as a passive-voice auxiliary: "[it] is set to 1..."

    Saying "default to 0" is like the perlism:
    setup values of v:

    v=0;               # default to 0
    v=1 if (X || Y);   # and set to 1 if X or Y is set
 
    I can't believe we are discussing grammer concerns in comments in
the linux-kenel.  :-) (!).

-linda

