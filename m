Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262537AbVFJKHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbVFJKHP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 06:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVFJKHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 06:07:15 -0400
Received: from guardian.hermes.si ([193.77.5.150]:60425 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S262537AbVFJKHH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 06:07:07 -0400
From: david.balazic@hermes.si
Date: Fri, 10 Jun 2005 12:06:18 +0200
Message-Id: <200506101006.j5AA6I914044@lastovo.hermes.si>
To: linux-kernel@vger.kernel.org
Subject: Possible typo in linux/limits.h, max path length
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resending, sorry if the first try also comes in)
Hi!

In linux-2.6.11/include/linux/limits.h , I see :

#define NAME_MAX         255    /* # chars in a file name */
#define PATH_MAX        4096    /* # chars in a path name including nul */

Is it really "chars" or actually "bytes" ?

AFAIK, the kernel does not care about the meaning of the data,
so it does not (need to) know how many chars it represents.


BTW, isn't 4096 a bit low ? WiXXXXX supports 32000 ;-)
(OK, it isn't low, but some apps and/or APIs enforce a lower
limit, like 1024, right ?)


Best regards,
David Balazic
