Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267760AbUJCI6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267760AbUJCI6g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 04:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267769AbUJCI6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 04:58:36 -0400
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:6311 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S267760AbUJCI6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 04:58:35 -0400
Message-ID: <415FBF35.20701@freeuk.com>
Date: Sun, 03 Oct 2004 09:58:29 +0100
From: David Crick <dcrick@freeuk.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.x: [no]lapic and start up / shutdown problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first 2.6 kernel (2.6.3) I ran on my ancient PII-300 box
required nolapic appended, otherwise the system would
say "halting" on shutdown, but then wouldn't power off.

Adding nolapic to recent kernels, however, means that
the system won't get past "calibrating delay loop..." on
start-up. This is true of 2.6.8.1, but started at least as far
back as 2.6.7.
