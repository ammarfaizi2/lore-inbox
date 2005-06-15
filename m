Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVFONh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVFONh3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 09:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVFONh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 09:37:29 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:4303 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S261422AbVFONh0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 09:37:26 -0400
To: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
MIME-Version: 1.0
Subject: Analysis of IO bug with kdump
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF73B8CDF4.A3A85473-ON65257021.004478CB-65257021.0045DE0F@in.ibm.com>
From: Nagesh Sharyathi <sharyathi@in.ibm.com>
Date: Wed, 15 Jun 2005 18:08:07 +0530
X-MIMETrack: Serialize by Router on d23m0069/23/M/IBM(Release 6.51HF653 | October 18, 2004) at
 15/06/2005 18:08:41,
	Serialize complete at 15/06/2005 18:08:41
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have encountered kernel oops while testing AIO. 
Since I had set panic_on_oops I  was able to take the memory dump through 
kdump,
I have run preliminary analysis over the dump using gdb and have attached 
the analysis, please look into the bug

http://bugme.osdl.org/show_bug.cgi?id=4721

and let me know if further analysis is needed
