Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbUKUPcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbUKUPcD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 10:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbUKUPcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 10:32:03 -0500
Received: from web41403.mail.yahoo.com ([66.218.93.69]:37294 "HELO
	web41403.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261318AbUKUPbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 10:31:55 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=S56cSMAhHj6w0bBzqUoKEPBSp2nboN+dw6A6n3sZnJflDjuKAex3C3WHGuCKDlh8//SpxdMUa3BuITCx7E6rmeRQlLxCx0icFyf4LI9jv5q7exfLF68bjDYBFEfhmA2ZhYPOtsxWu1KIGTF7gFx0akSaxZcc3oDjI2q8MhRc5kQ=  ;
Message-ID: <20041121153154.85910.qmail@web41403.mail.yahoo.com>
Date: Sun, 21 Nov 2004 07:31:54 -0800 (PST)
From: cranium2003 <cranium2003@yahoo.com>
Subject: how netfilter handles fragmented packets
To: kernelnewbies@nl.linux.org
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       netdev@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
          In ip_output.c file ip_fragmet function when
create a new fragmented packet given to output(skb)
function. i want to know which function are actually
called by output(skb)?
          Is that function ip_finish_output? if yes
then fragmented packet has not gone through netfilter
hooks specially NF_IP_LOCAL_OUT?
          so does that mean fragmented packets not
travel through netfilter hooks?
regards,
cranium


		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - Get yours free! 
http://my.yahoo.com 
 

