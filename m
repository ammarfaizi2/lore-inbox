Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbVIGISW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVIGISW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 04:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbVIGISW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 04:18:22 -0400
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:64721 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S1751181AbVIGISV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 04:18:21 -0400
Message-ID: <431EA245.2040703@stud.feec.vutbr.cz>
Date: Wed, 07 Sep 2005 10:18:13 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nazim khan <naz_taurus@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to find out kernel stack over flow?
References: <20050907072824.98733.qmail@web52604.mail.yahoo.com>
In-Reply-To: <20050907072824.98733.qmail@web52604.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nazim khan wrote:
> I suspect that one of my module that I am inserting in
> the kernel may be causing the stack overflow which is
> leading to kernel crash (may because it is corrupting
> some one lese memory).
> 
> How can I find this out?

You could enable CONFIG_DEBUG_STACKOVERFLOW.
If you showed us your module's source code, someone might see the bug.

Michal
