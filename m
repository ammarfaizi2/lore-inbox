Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262981AbTCLCot>; Tue, 11 Mar 2003 21:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262983AbTCLCot>; Tue, 11 Mar 2003 21:44:49 -0500
Received: from dsl2-09018-wi.customer.centurytel.net ([209.206.215.38]:38282
	"HELO thomasons.org") by vger.kernel.org with SMTP
	id <S262981AbTCLCot>; Tue, 11 Mar 2003 21:44:49 -0500
From: scott thomason <scott-kernel@thomasons.org>
Reply-To: scott-kernel@thomasons.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: bio too big device
Date: Tue, 11 Mar 2003 20:55:31 -0600
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303112055.31854.scott-kernel@thomasons.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I frequently receive this message in my syslog, apparently 
whenever there are periods of significant write activity:

    bio too big device ide0(3,7) (256 > 255)
    bio too big device ide1(22,6) (256 > 255)

It's worth noting that on this system I have had ongoing trouble 
with system stability during write activity as well, using a 
wide variety of 2.5.x kernels, even though at the time of this 
symptom things are apparently running fine.

Filesystems are all ext3 on top soft raid0 devices. This happens 
to be 2.5.64, but it has been happening for at least the last 
5-6 versions.

Ideas? Any further debugging output I can provide?
---scott
