Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbUKQUOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbUKQUOi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbUKQUNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:13:12 -0500
Received: from v6.netlin.pl ([62.121.136.6]:30476 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262403AbUKQUMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:12:33 -0500
Message-ID: <419BB097.8030405@kde.org.uk>
Date: Wed, 17 Nov 2004 21:12:07 +0100
From: Grzegorz Piotr Jaskiewicz <gj@kde.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: pid_max madness
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let's do:
#echo "-1" >/proc/sys/kernel/pid_max
#cat /proc/sys/kernel/pid_max
-1
#

Madness, isn't ?

I guess that isn't what author ment it to behave like.
Anyway, does it mean that after max unsigned value is reached pids are 
going to be negative in value ??

--
GJ
