Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262975AbVAFSIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262975AbVAFSIt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 13:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbVAFSDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 13:03:47 -0500
Received: from smtpout.mac.com ([17.250.248.46]:46834 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262973AbVAFSA6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 13:00:58 -0500
In-Reply-To: <1105023040.4028.36.camel@localhost.localdomain>
References: <1104979908.8060.34.camel@localhost.localdomain> <20050105212629.K469@build.pdx.osdl.net> <1105023040.4028.36.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <EA341136-600C-11D9-892F-000D9352858E@mac.com>
Content-Transfer-Encoding: 8BIT
Cc: narahimi@us.ibm.com, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
From: Felipe Alfaro Solana <lkml@mac.com>
Subject: Re: [PATCH] Enhanced Trusted Path Execution (TPE) Linux Security	Module
Date: Thu, 6 Jan 2005 19:00:56 +0100
To: =?ISO-8859-1?Q?Lorenzo_Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Jan 2005, at 15:50, Lorenzo Hernández García-Hierro wrote:

>> The two biggest issues are 1) it's trivial to bypass:
>> $ /lib/ld.so /untrusted/path/to/program
>> and 2) that there's no (visible/vocal) user base calling for the 
>> feature.
>
> About the point 1), yesterday i wrote just a simple regression test
> (that can be found at the same place as the patch) and of course it
> bypasses, this is an old commented problem, Stephen suggested the use 
> of
> the mmap and mprotect hooks, so, i will have a look at them but i'm not
> sure on how to (really) prevent the dirty,old trick.
> About 2), just give it a chance, maybe it's useful and my work is not
> completely nonsense.

Well, I'm not a visible/vocal user base, but I do really like this TPE 
LSM module.
