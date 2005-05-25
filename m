Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVEYRuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVEYRuZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 13:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVEYRuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 13:50:25 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:31175 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261516AbVEYRuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 13:50:20 -0400
Message-ID: <4294BAD8.4030300@nortel.com>
Date: Wed, 25 May 2005 11:50:16 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: proper API for sched_setaffinity ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my system (Mandrake 10.0) the man page for sched_setaffinity() lists 
the prototype as:

int  sched_setaffinity(pid_t  pid,  unsigned  int  len,  unsigned  long
        *mask);


But /usr/include/sched.h gives it as

extern int sched_setaffinity (__pid_t __pid, __const cpu_set_t *__mask)

Which is correct?

Chris
