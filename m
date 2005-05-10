Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVEJIG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVEJIG3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 04:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVEJIG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 04:06:28 -0400
Received: from gourmet.spamgourmet.com ([216.218.230.146]:37781 "EHLO
	gourmet.spamgourmet.com") by vger.kernel.org with ESMTP
	id S261569AbVEJIG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 04:06:26 -0400
Message-ID: <42806B78.2020708@home.se>
Date: Tue, 10 May 2005 10:06:16 +0200
From: linuxkernel2.20.sandos@spamgourmet.com
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: E1000 - page allocation failure - saga continues :(
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-mdh_se-MailScanner-Information: Please contact the ISP for more information
X-mdh_se-MailScanner: Found to be clean
X-MailScanner-From: sandos@home.se
X-Spamgourmet: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >Anyway i'll try to catch THE option that make the kernel not so happy
 >under heavy stress. Stay tuned

How did this turn out? Any luck? Im seeing this same problem with my 
e1000, now I did enable rx/tx flow control, I reniced kswapd and I 
changed vm.min_free_kbytes to 65536, and the problem went away.

It would be nice with a "cleaner" solution though.

---
John Bäckstrand
