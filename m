Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVATWNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVATWNt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 17:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVATWNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 17:13:48 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:11499 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262182AbVATWKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 17:10:05 -0500
Message-ID: <41F02C35.3030001@nortelnetworks.com>
Date: Thu, 20 Jan 2005 16:09:57 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [bug?]  strange behaviour with longjmp, itimer, and read/recv
 (but not pause) -- solved
References: <41F026E1.5050006@nortelnetworks.com> <41F02877.5010508@nortelnetworks.com>
In-Reply-To: <41F02877.5010508@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bah...

As all of you no doubt suspected, I should have been using 
sigsetjmp()/siglongjmp().

Sorry to waste your time.

Chris
