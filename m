Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262570AbUKRFyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbUKRFyo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 00:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbUKRFyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 00:54:44 -0500
Received: from p508F0667.dip0.t-ipconnect.de ([80.143.6.103]:16700 "EHLO
	mail.morknet.de") by vger.kernel.org with ESMTP id S262570AbUKRFym
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 00:54:42 -0500
Message-ID: <419C38DF.1050802@morknet.de>
Date: Thu, 18 Nov 2004 06:53:35 +0100
From: "Steffen A. Mork" <linux-dev@morknet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: de, en, el
MIME-Version: 1.0
To: Tonnerre <tonnerre@thundrix.ch>
CC: "Steffen A. Mork" <linux-dev@morknet.de>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au, torvalds@osdl.org
Subject: Re: [PATCH] dss1_divert ISDN module compile fix for kernel 2.6.8.1
References: <419B662D.5020904@morknet.de> <20041117224315.GA2198@pauli.thundrix.ch>
In-Reply-To: <20041117224315.GA2198@pauli.thundrix.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir Milter (version: 1.1; AVE: 6.28.0.12; VDF: 6.28.0.78; host: mail.morknet.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Salut,
Hallo,

> On Wed, Nov 17, 2004 at 03:54:37PM +0100, Steffen A. Mork wrote:
> 
>>http://ls7-www.cs.uni-dortmund.de/~mork/dss1_divert.diff
> 
> 
> This patch is wrong. You're using a spinlock you declare on the stack 
> of a function, so it's completely pointless.
You are right. I've corrected my mistake already. Look at

http://ls7-www.cs.uni-dortmund.de/~mork/dss1_divert-patch1-2-patch2.diff

to correct that patch or

http://ls7-www.cs.uni-dortmund.de/~mork/dss1_divert-patch2.diff

for the complete correct patch.

> Please look at http://users.thundrix.ch/~tonnerre/kernel/2.6.1-tch1/ 
> where I gathered lots of ISDN patches a while ago. It might be a start 
> for you.
Thank you.


> 			    Tonnerre
Steffen


