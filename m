Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263445AbUJ2T5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263445AbUJ2T5s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbUJ2Tzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:55:35 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:23732 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263479AbUJ2ToU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:44:20 -0400
Subject: RE: [PATCH] [swsusp] print error message when swapping is disabled
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Zhu, Yi" <yi.zhu@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD305756F342F@pdsmsx402.ccr.corp.intel.com>
References: <16A54BF5D6E14E4D916CE26C9AD305756F342F@pdsmsx402.ccr.corp.intel.com>
Content-Type: text/plain
Message-Id: <1099078254.4805.7.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 30 Oct 2004 05:30:54 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-10-29 at 19:54, Li, Shaohua wrote:
> Enable DEBUG_PAGEALLOC will disable PSE. 
> Possibly a stupid question, why swsusp need PSE? I didn't see any
> relationship between the two.

I have suspend2 working with DEBUG_PAGEALLOC. I just had to add code to
map the original pages before making the atomic copy, so that resume
will work (and unmap them afterwards, of course).

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Everyone lives by faith. Some people just don't believe it.
Want proof? Try to prove that the theory of evolution is true.

