Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWJHO2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWJHO2r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 10:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWJHO2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 10:28:46 -0400
Received: from drugphish.ch ([69.55.226.176]:23221 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S1751194AbWJHO2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 10:28:46 -0400
Message-ID: <45290B18.2050905@drugphish.ch>
Date: Sun, 08 Oct 2006 16:28:40 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible recursive locking detected: kseriod on 2.6.19-rc1-gb0eb0838
References: <4528DE50.5020807@drugphish.ch> <200610081019.11009.dtor@insightbb.com>
In-Reply-To: <200610081019.11009.dtor@insightbb.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I don't know if this has been reported before, but here goes:
> 
> Thank you for the report. It is a false positive, we have a patch
> to silence lockdep here.

Ahh, that explains it. I've looked at the code in question for half an 
hour and couldn't figure out what's wrong with the locking.

Cheers,
Roberto Nibali, ratz
-- 
echo 
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
