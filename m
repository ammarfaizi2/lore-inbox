Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262910AbVCQAZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbVCQAZC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 19:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbVCQAYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 19:24:48 -0500
Received: from main.gmane.org ([80.91.229.2]:2191 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262889AbVCQAW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 19:22:27 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ian Pilcher <i.pilcher@comcast.net>
Subject: Re: [2/9] Possible AMD8111e free irq issue
Date: Wed, 16 Mar 2005 18:19:52 -0600
Message-ID: <d1aicj$iq1$2@sea.gmane.org>
References: <20050316235336.GY5389@shell0.pdx.osdl.net> <20050316235427.GA5389@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-0-215-239.client.comcast.net
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
In-Reply-To: <20050316235427.GA5389@shell0.pdx.osdl.net>
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner-SpamScore: ss
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> 
> From: Andres Salomon <dilinger@debian.org>
> 
> It seems to me that if in the amd8111e_open() fuction dev->irq isn't
> zero and the irq request succeeds it might not get released anymore.
> 

Based on the wording above, I can't help wondering if this fixes a
problem that anyone is actually seeing.

-- 
========================================================================
Ian Pilcher                                        i.pilcher@comcast.net
========================================================================

