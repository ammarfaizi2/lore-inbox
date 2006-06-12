Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWFMXKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWFMXKR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 19:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWFMXKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 19:10:16 -0400
Received: from smtpout.mac.com ([17.250.248.174]:27365 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964794AbWFMXKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 19:10:15 -0400
In-Reply-To: <1150100286.26402.13.camel@tara.firmix.at>
References: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com> <193701c68d16$54cac690$0225a8c0@Wednesday> <1150100286.26402.13.camel@tara.firmix.at>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AC44C19E-109F-4DD4-933E-B641BF3BF9CB@mac.com>
Cc: David Schwartz <davids@webmaster.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>, jdow <jdow@earthlink.net>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Date: Mon, 12 Jun 2006 07:42:06 -0400
To: Bernd Petrovitsch <bernd@firmix.at>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 12, 2006, at 04:18:06, Bernd Petrovitsch wrote:
> No. SPF simply defines legitimate outgoing MTAs for a given domain.

I'm sorry, but the internet just doesn't work that way.  I have 3  
email accounts (mac.com, vt.edu, and cox.net).  Both my college and  
my house deny all SMTP to anyone but their local servers.  If mac.com  
published an SPF filter and VGER used the SPF filter, I would have no  
way at all to send mail via this account, simply for the reason that  
neither of my local ISPs will allow my to directly send email to  
mac.com.  Likewise for my vt.edu account while at home or my cox.net  
account while at college.

IMHO, turning on SPF will not gain anything for the LKML; a bayesian  
filter based solution would be much more tenable.

Cheers,
Kyle Moffett

