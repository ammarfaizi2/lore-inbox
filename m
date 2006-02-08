Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422655AbWBHXvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422655AbWBHXvm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 18:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422656AbWBHXvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 18:51:42 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:62381 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1422655AbWBHXvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 18:51:42 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43EA8405.1070700@s5r6.in-berlin.de>
Date: Thu, 09 Feb 2006 00:51:33 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 7/8] don't mangle INQUIRY if cmddt or evpd bits are set
References: <E1F6vyJ-00009k-3Z@ZenIV.linux.org.uk> <43EA7226.60306@s5r6.in-berlin.de> <20060208230559.GK27946@ftp.linux.org.uk>
In-Reply-To: <20060208230559.GK27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.742) AWL,BAYES_05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Wed, Feb 08, 2006 at 11:35:18PM +0100, Stefan Richter wrote:
>>In fact, not a single one of these bridges is affected by the code 
>>change since the additional expression which was added always evaluates 
>>true.
> 
> The hell it does.  Try scsiinfo -s and you'll see.  All INQUIRY generated
> by scsi midlayer have both flags set to 0.  Userland ones do not;

Ah, I see. Of course I didn't test that.
-- 
Stefan Richter
-=====-=-==- --=- -=--=
http://arcgraph.de/sr/
