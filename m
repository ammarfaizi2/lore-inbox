Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVGFTs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVGFTs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVGFTpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:45:40 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:21514 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S262343AbVGFOnQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 10:43:16 -0400
Message-ID: <42CBEDF9.3030200@stud.feec.vutbr.cz>
Date: Wed, 06 Jul 2005 16:43:05 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050603)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Prowel <tempest766@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: please remove reserved word "new" from kernel headers
References: <20050706092657.95280.qmail@web60012.mail.yahoo.com>
In-Reply-To: <20050706092657.95280.qmail@web60012.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Prowel wrote:
> [1.] One line summary of the problem:    
> 
> 2.4 and 2.6 kernel headers use c++ reserved word "new"
> as identifier in function prototypes.

Yes, the kernel is written in C, not C++.

> using the identifier "new" in kernel headers that are
> visible to applications programs is a bad idea.

Programs are not supposed to include kernel headers.
This is a FAQ, see the archives.

Michal
