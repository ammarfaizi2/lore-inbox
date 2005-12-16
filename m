Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbVLPBkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbVLPBkF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 20:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbVLPBkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 20:40:05 -0500
Received: from mail.dvmed.net ([216.237.124.58]:3299 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751272AbVLPBkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 20:40:02 -0500
Message-ID: <43A21AED.5020700@pobox.com>
Date: Thu, 15 Dec 2005 20:39:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH 0/3] *at syscalls: Intro
References: <200512152249.jBFMnXAA016747@devserv.devel.redhat.com> <43A20B0B.5090205@pobox.com> <43A2187B.2050909@redhat.com>
In-Reply-To: <43A2187B.2050909@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Ulrich Drepper wrote: > Jeff Garzik wrote: > >> It
	would be nice to add the additional argument to path_lookup(), >>
	rather than calling do_path_lookup() everywhere. > > > path_lookup is
	unfortunately exported. If breaking the ABI is no issue > I'll change
	it. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Jeff Garzik wrote:
> 
>> It would be nice to add the additional argument to path_lookup(), 
>> rather than calling do_path_lookup() everywhere.
> 
> 
> path_lookup is unfortunately exported.  If breaking the ABI is no issue 
> I'll change it.

Yep, I saw it was exported.  I would prefer to change the API, but my 
preference doesn't carry much weight:  I have no idea if there are any 
important out-of-tree users or not.

	Jeff


