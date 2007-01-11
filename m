Return-Path: <linux-kernel-owner+w=401wt.eu-S1030378AbXAKO7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbXAKO7d (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 09:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030440AbXAKO7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 09:59:33 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:43608 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030378AbXAKO7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 09:59:32 -0500
Message-ID: <45A650D2.90901@bull.net>
Date: Thu, 11 Jan 2007 15:59:30 +0100
From: Jacky Malcles <Jacky.Malcles@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: can't cleanup /proc/swaps without rebooting ?
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/01/2007 16:07:40,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 11/01/2007 16:07:42,
	Serialize complete at 11/01/2007 16:07:42
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi All,

Please could you cc me because I'm not subscribed.


is there a way, other than rebooting, to clean up /proc/swaps ?

I'm in this situation (due to testing errors),
# cat /proc/swaps
Filename                                Type            Size    Used    Priority
/dev/sdc1                               partition       2040064 0       -1
/tmp/swaH4mvTI/swapfilenext\040(deleted) file           48960   0       -31
/tmp/swa5TlBva/swapfilenext\040(deleted) file           49088   0       -118
#
# swapon -s
Filename                                Type            Size    Used    Priority
/dev/sdc1                               partition       2040064 0       -1
/tmp/swaH4mvTI/swapfilenext\040(deleted) file           48960   0       -31
/tmp/swa5TlBva/swapfilenext\040(deleted) file           49088   0       -118
#

many thanks,

-- 
  Jacky Malcles    	     B1-403   Email : Jacky.Malcles@bull.net
  Bull SA, 1 rue de Provence, B.P 208, 38432 Echirolles CEDEX, FRANCE
  Tel : 04.76.29.73.14
