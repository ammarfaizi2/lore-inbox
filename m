Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161123AbVKRS7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbVKRS7e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 13:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbVKRS7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 13:59:34 -0500
Received: from moutvdom.kundenserver.de ([212.227.126.249]:9470 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161123AbVKRS7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 13:59:33 -0500
Message-ID: <437E2494.6010005@anagramm.de>
Date: Fri, 18 Nov 2005 19:59:32 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.14.2 - Hard link count is wrong
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, There!

On a newly installed 2.6.14.2 (vanilla), when I do a

root@testserver: /$ find | grep something.conf

I get

.....
find: WARNING: Hard link count is wrong for .: this may be a bug in your filesystem driver.  Automatically turning on find's -noleaf option.  Earlier results may have failed to include directories that should have been searched.

According to google, this might be a kernel bug due to some problems in /proc, see:
https://www.redhat.com/archives/fedora-list/2005-September/msg02474.html
Well, how to debug that problem?

Greets,

-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
