Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266033AbTFWNS6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 09:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266031AbTFWNSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 09:18:34 -0400
Received: from nuit.ca ([66.11.160.83]:9134 "EHLO smtp.nuit.ca")
	by vger.kernel.org with ESMTP id S266030AbTFWNR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 09:17:28 -0400
Date: Mon, 23 Jun 2003 13:31:33 +0000
From: simon@nuit.ca
To: linux-kernel@vger.kernel.org
Subject: Re: problems patching XFS against current benh
Message-ID: <20030623133133.GE2102@nuit.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-SA-Exim-Mail-From: simon@nuit.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> mark_page_accessed is exported in both ksyms.c and filemap.c, both XFS
> and benh add that export.  Remove one of the EXPORT_SYMBOL(mark_page_accessed).
>                                                                                                                                

at first i didn't get what you meant, but then i realised, "oh, he means
only in one file should the EXPORT_SYMBOL(foo) should be mentioned".
someone on an IRC channel had mentioned that...

>> number 1 is from benh, and number 2 is from XFS. i need both - benh's for some drivers for my hardware, and XFS 
>> because most of my FSes are XFS. 

> The sysctl numbers have nothing to do with the compile error.  Pick
> another number for one of the conflicting sysctls.

ok, cool, thanks. i wasn't sure if my changing the stsctl number was
causing it, so i had left it at 14 the second ? third ? time around...

thanks all,
eric
(feeling really dumb ATM)

-- 
UNIX is user friendly, it's just picky about who its friends are.          
-------------------------------------------------------------------
 ,''`.   http://www.debian.org/  | http://www.nuit.ca/           
 : :' :  Debian GNU/Linux        | http://simonraven.nuit.ca/    
 `. `'                           | PGP key ID: 6169 BE0C 0891 A038    
  `-                             | 
