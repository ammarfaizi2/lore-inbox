Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUGZU7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUGZU7H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 16:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265947AbUGZU54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 16:57:56 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:53645 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S266078AbUGZUqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 16:46:34 -0400
Message-ID: <4105D00E.8040203@austin.rr.com>
Date: Mon, 26 Jul 2004 22:46:22 -0500
From: Steven French <smfrench@austin.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Is there an uninterruptible replacement for the deprecated sleep_on_timeout?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a note in include/linux/wait.h that the sleep_on* functions are 
racy and the wait* functions (listed earlier in the same file) should be 
used instead, but there only seems to be replacements for the 
interruptible versions of those sleep_on functions, is there a reason 
why there is not a "wait_event_timeout_uninterruptible" macro to replace 
sleep_on_timeout?
