Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263089AbRFRVH5>; Mon, 18 Jun 2001 17:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263092AbRFRVHr>; Mon, 18 Jun 2001 17:07:47 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.121.50]:16358 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S263089AbRFRVHh>; Mon, 18 Jun 2001 17:07:37 -0400
Message-ID: <3B2E6EA3.3DED7D95@earthlink.net>
Date: Mon, 18 Jun 2001 16:12:03 -0500
From: Kelledin Tane <runesong@earthlink.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Why can't I flush /dev/ram0?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At this point, I'm trying to get an initrd working properly.  So far, it
works, the system boots, etc. etc., but whenever I try to do a "blockdev
--flushbufs /dev/ram0", I get "device or resource busy"

When I mount the filesystem to check it out, nothing appears to have
anything open on the filesystem.  So why am I not able to flush it
clean?

This is kernel 2.4.5 stock, btw.

Kelledin

