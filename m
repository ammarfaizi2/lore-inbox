Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbVL3EAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbVL3EAF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 23:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbVL3EAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 23:00:05 -0500
Received: from main.gmane.org ([80.91.229.2]:14242 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750842AbVL3EAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 23:00:02 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Subject: cpufreq: powernow-k8 frequency transitions question
Date: Fri, 30 Dec 2005 05:00:09 +0100
Message-ID: <dp2bbc$r4n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212.117.85.171
User-Agent: KNode/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm currently reading and playing with the powernow-k8 cpufreq driver
module. However so far I wasn't able to find out how frequency transitions
are dealt with that have to be made using intermediate steps, ie.
transitions which cannot be done in one single step.

(I read about this at 
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/26094.PDF
p. 269f.)

I found safety guards which return an error if an invalid frequency
transition ("lo-lo transition") is requested. Is this the only support for
these transitions currently implemented or did I miss something?
Is there more advanced support simply missing, or is the current behaviour
sufficient, and if yes, why does this suffice?

How do the conservative/ondemand cpufreq governors cope with the kernel
advertising frequencies it cannot directly transition between?

I'd be really cool if someone could enlighten me, just some pointers at
powernow-k8.c functions I should take a closer look at might already
help. :-)

Greetings,

  Gunter

-- 
Due to hw failure, I'm thinking buying a new laptop.  I would like to 
know what is the worst laptop with ACPI atm?        -- Linux ACPI 
driver hacker Bruno Ducrot looking for a "good" laptop... ;)
*** PGP-Verschlüsselung bei eMails erwünscht :-) *** PGP: 0x1128F25F ***

