Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264489AbTLQSCl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 13:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbTLQSCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 13:02:41 -0500
Received: from mail48-s.fg.online.no ([148.122.161.48]:16068 "EHLO
	mail48.fg.online.no") by vger.kernel.org with ESMTP id S264489AbTLQSCk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 13:02:40 -0500
To: linux-kernel@vger.kernel.org
Subject: video4linux headers
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 17 Dec 2003 19:02:37 +0100
Message-ID: <yw1xvfofnwzm.fsf@kth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When compiling any program that uses video4linux under linux
2.6.0-testANY, I always get these errors:

In file included from /usr/include/linux/videodev2.h:16,
/usr/include/linux/time.h:9: redefinition of `struct timespec'
/usr/include/linux/time.h:15: redefinition of `struct timeval'
/usr/include/time.h:160: redefinition of `struct itimerspec'

Am I doing something terribly wrong?  Simply placing an
#include <linux/time> in videodev2.h under #ifdef __KERNEL__ seems to
get rid of the compiler errors, though I'm sure that's not the proper
solution.

-- 
Måns Rullgård
mru@kth.se
