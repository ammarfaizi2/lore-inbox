Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263090AbVEGMkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbVEGMkN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 08:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbVEGMkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 08:40:13 -0400
Received: from web60524.mail.yahoo.com ([209.73.178.172]:61361 "HELO
	web60524.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263085AbVEGMj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 08:39:59 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=cPqqVjLHm5jcsRr4hJQHE/HP+CWAVbVom1vBeYtLdImkG6UQthdfXQMSOKPK/tBE5x3N/SBd7hgDauz6OlDYfNTYFuqjAMJQ0p1h9r9zYLaNl97QVOMEaBMG/nrlPW9ECapmIQE4b+tqVaj0+GcF6ifQqplpFECF3dtoRN5aTzc=  ;
Message-ID: <20050507123956.53734.qmail@web60524.mail.yahoo.com>
Date: Sat, 7 May 2005 05:39:56 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: oprofile: enabling cpu events
To: linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to profile cpu events using oprofile, when i
issue following command, it gives me an error saying
that oprofile is in timer mode.
What does it mean ?
the link
http://oprofile.sourceforge.net/docs/intel-piii-events.php3
says event=CPU_CLK_UNHALTED is suppported for Pentium
II processor.

Is there any way i can enable cpu events ?

# opcontrol --setup  --event=CPU_CLK_UNHALTED
You cannot specify any performance counter events
because OProfile is in timer mode.

#opcontrol --event=CPU_CLK_UNHALTED
You cannot specify any performance counter events
because OProfile is in timer mode.

-lnxluv





		
__________________________________ 
Yahoo! Mail Mobile 
Take Yahoo! Mail with you! Check email on your mobile phone. 
http://mobile.yahoo.com/learn/mail 
