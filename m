Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbUCaFJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 00:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUCaFJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 00:09:54 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:20198 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S261741AbUCaFJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 00:09:53 -0500
X-OB-Received: from unknown (205.158.62.182)
  by wfilter.us4.outblaze.com; 31 Mar 2004 05:08:57 -0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "dan carpenter" <error27@email.com>
To: linux-kernel@vger.kernel.org
Cc: ltp-list@lists.sourceforge.net
Date: Tue, 30 Mar 2004 23:50:28 -0500
Subject: file system race condition testing
X-Originating-Ip: 67.113.20.209
X-Originating-Server: ws3-6.us4.outblaze.com
Message-Id: <20040331045028.0B4581CE504@ws3-6.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wrote this script a while back.  It creates 20 files, 0 through 19,
and then shuffles them around, deletes and recreates them as fast as 
possible.

It's a good way to test for race conditions.  I always run with 
preempt turned on so that makes my system more sensitive to race 
conditions.  Neither JFS or Reiserfs survived a whole night of testing 
on my system.  It's a pretty grueling test...  

http://67.113.20.209/racer.tar.gz

regards,
dan


-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

