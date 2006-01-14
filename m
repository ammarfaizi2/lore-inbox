Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWANWJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWANWJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWANWJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:09:27 -0500
Received: from mail.dvmed.net ([216.237.124.58]:58254 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751318AbWANWJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:09:26 -0500
Message-ID: <43C97693.7000109@pobox.com>
Date: Sat, 14 Jan 2006 17:09:23 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (other issues)
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com> <20060113213237.GH16166@tuxdriver.com> <20060113222408.GM16166@tuxdriver.com>
In-Reply-To: <20060113222408.GM16166@tuxdriver.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  John W. Linville wrote: > Other Issues > ============ A
	big open issue: should you fake ethernet, or represent 802.11 natively
	throughout the rest of the net stack? The former causes various and
	sundry hacks, and the latter requires that you touch a bunch of
	non-802.11 code to make it aware of a new frame class. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> Other Issues
> ============

A big open issue:  should you fake ethernet, or represent 802.11 
natively throughout the rest of the net stack?

The former causes various and sundry hacks, and the latter requires that 
you touch a bunch of non-802.11 code to make it aware of a new frame class.

	Jeff



