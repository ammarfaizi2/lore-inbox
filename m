Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVGBJ6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVGBJ6D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 05:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVGBJ6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 05:58:02 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:26022 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S261660AbVGBJ5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 05:57:12 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <42C664CE.9020009@s5r6.in-berlin.de>
Date: Sat, 02 Jul 2005 11:56:30 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Reply-To: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
CC: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Firewire/SBP2 and the -mm tree
References: <20050701044018.281b1ebd.akpm@osdl.org> <200507020005.04947.rjw@sisk.pl> <20050702031955.GC28251@ime.usp.br>
In-Reply-To: <20050702031955.GC28251@ime.usp.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: (-1.556) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogério Brito wrote:
> Is there any estimated possibility of including an update from the
> linux1394 team in future versions of -mm or, even better, pushing them to
> Linus's tree?

That is what usually happens. But the sbp2 related diffs between 2.6.13 
and linux1394 are not an update by linux1394 but rather a rewrite by the 
scsi folk. Unfortunately, that rewrite was not tested by the linux1394 
team. (And was therefore not checked in at svn.linux1394.org. Lack of 
manpower was one factor.) So, applying the sbp2 portion of your diff is 
a back-out, not an update.

I have a question: Do you need _both_ the sbp2 back-out and ieee1394's 
disable_irm parameter, or only one of them?
-- 
Stefan Richter
-=====-=-=-= -=== ---=-
http://arcgraph.de/sr/
