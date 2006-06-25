Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWFYJR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWFYJR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 05:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWFYJR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 05:17:56 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:52843 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932155AbWFYJRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 05:17:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NdwOTs81xcw/cmiTBcxP02JVcXB1PRlRkVgLdGsJ/tgI4nXnAQvYbeMKEVWc34YZfZ3/dQ1APvxyvrf6IdZf/rvJa/9NZGqEOMhboJb3JTTDdA+XQvUdE2CAGEHfpA7plHkXxyJ4sIVSkdRsZHjGTIv7UyZGEOhOJBefNWyuwi0=
Message-ID: <8bf247760606250217i5c0079f2o997be3518b22d7a6@mail.gmail.com>
Date: Sun, 25 Jun 2006 14:47:55 +0530
From: Ram <vshrirama@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Badness in remove_proc_entry in wlan driver unregistration.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 when i try to unload a wlan driver i get  the message:

 Badness in remove_proc_entry at fs/proc/generic.c:705


  This comes from the statment in the driver:
wlan_proc_remove("wlan");


  How does one solve the problem.


  This wlan driver was in 2.4. i ported it to 2.6. Is there any
difference as far as wlan/networking unregistering is concerned for a
wlan driver.


  Any pointers?
 Please Advice.

Regards,
sriram
