Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbVHLNFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbVHLNFe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 09:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVHLNFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 09:05:33 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:36199 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751165AbVHLNFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 09:05:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=NxjaSX1OXR7uGmUQxeS3vPmkh3GOrHa01w6pn1Ewh3Ti92s6YxW1+CoQwyyku7siOKHvkDfXyu/u1GqTgWCithjZ266UKfhJI9pV9CCGK5mqqBij3Nt3GKp1q2Dan4bWW785qEumZoVbbdGLmJsYL7Ig+Cgi27Y0ot+qbdS/auE=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Really BAD granularity example in BKCVS output
Date: Tue, 9 Aug 2005 21:20:48 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200508092120.48236.blaisorblade@yahoo.it>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've locally downloaded and installed the GIT version of the BitKeeper tree 
(the first existing upload - have been away for a while, don't know if there 
are others), and while browsing the history for some work, I found this 
commit:

http://localhost/~paolo/git/?p=old-2.6-bkcvs/.git;a=commit;h=b035f9332ce7e205af43f7cfdf4e1cf3625f7ad5

(the hashes work on the kernel.org copy of that repository, assuming it wasn't 
re-exported).

Well, that is *awfully* big (543 files touched)! Isn't there anything which 
can be done about that? What is worse, the commit message is truncated!

And yes, sorry if this is a stupid question.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com
