Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVDCLzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVDCLzt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 07:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVDCLzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 07:55:48 -0400
Received: from mail.hosted.servetheworld.net ([62.70.14.38]:7918 "HELO
	mail.hosted.servetheworld.net") by vger.kernel.org with SMTP
	id S261699AbVDCLzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 07:55:44 -0400
Message-ID: <424FD9BB.7040100@osvik.no>
Date: Sun, 03 Apr 2005 13:55:39 +0200
From: Dag Arne Osvik <da@osvik.no>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Use of C99 int types
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been working on a new DES implementation for Linux, and ran into
the problem of how to get access to C99 types like uint_fast32_t for
internal (not interface) use.  In my tests, key setup on Athlon 64 slows
down by 40% when using u32 instead of uint_fast32_t.

So I wonder if there is any standard way of, say, including stdint.h for
internal use in kernel code?

   Dag Arne
