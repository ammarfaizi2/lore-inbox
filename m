Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVASUBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVASUBy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 15:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVASUBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 15:01:54 -0500
Received: from web53810.mail.yahoo.com ([206.190.36.205]:29293 "HELO
	web53810.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261706AbVASUBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 15:01:47 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=hfqg1esnYKFY83O/y4vkSJGK62GaXMXOeB8p1ABps07FX+4UKqYwy4KWFyB1rMKzoSdFhz6CcBgQvDvbKjkKTk7r53W7GZJfVFEgXKfxhMvk//U7kAyreODtRM3Xt++O/UO88599RfxKeKC3LgQI8NYo9uzJoYpd8Hn8VDitxTU=  ;
Message-ID: <20050119200143.52584.qmail@web53810.mail.yahoo.com>
Date: Wed, 19 Jan 2005 12:01:43 -0800 (PST)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: Re: Linux-tracecalls, a new tool for Kernel development, released
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only five minutes old, and already a patch ;)


--- lnxtc.pl-old      2005-01-19 12:09:00.000000000 -0800
+++ lnxtc.pl-new      2005-01-19 12:09:38.000000000 -0800
@@ -627,6 +627,7 @@
    $debug = 0;
 }

+$ENV{'PATH'}='/bin:/usr/bin';

 #Redirect standard error to logfile (fatals also to browser)
 unless($nohtml)

