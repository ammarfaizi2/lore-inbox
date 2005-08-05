Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262680AbVHESK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbVHESK3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbVHESIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:08:00 -0400
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:7353 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S262680AbVHESHq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:07:46 -0400
X-OB-Received: from unknown (205.158.62.81)
  by wfilter.us4.outblaze.com; 5 Aug 2005 18:07:39 -0000
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
From: "marijn ros" <marijn@mad.scientist.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 05 Aug 2005 19:07:39 +0100
Subject: fsnotify on removexattr
X-Originating-Ip: 82.92.29.252
X-Originating-Server: ws1-2.us4.outblaze.com
Message-Id: <20050805180739.A49DF1F50B1@ws1-2.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got wondering, why does fs_notify_xattr get called from setxattr in fs/xattr.c, but not from removexattr that is below it in the same file? Both seem to make changes to xattrs and both are exported as system calls.

Bye,
 Marijn

-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

