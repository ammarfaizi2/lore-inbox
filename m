Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266464AbRHOVmr>; Wed, 15 Aug 2001 17:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266921AbRHOVmh>; Wed, 15 Aug 2001 17:42:37 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:11497 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S266464AbRHOVmY>; Wed, 15 Aug 2001 17:42:24 -0400
Message-ID: <098c01c125d3$127095e0$103147ab@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Coding convention of function header comments
Date: Wed, 15 Aug 2001 14:41:41 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

Sorry maybe this is not the best place to ask, but recently I need to come
up with coding conventions regarding function header comments which explain
the usage of functions (meaning of parameters, etc).  <linux/list.h> has sth
like this:

/**
 * list_add - add a new entry
 * @new: new entry to be added
 * @head: list head to add it after
 *
 * Insert a new entry after the specified head.
 * This is good for implementing stacks.
 */
static __inline__ void list_add(struct list_head *new, struct list_head
*head)
{
 __list_add(new, head, head->next);
}

Similar to Java.  I want to ask that (1) is this a well-known convention or
was just invented (informally) by someone here (e.g., Linus?)?  Where can I
find the documentation about this convention? (2) can anyone point me to the
URL of similar well-known coding conventions (except the Java one)?

Many thanks.

-Hua


