Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUHMLnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUHMLnJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 07:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUHMLnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 07:43:09 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:8256 "EHLO
	smtp-out3.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262927AbUHMLnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 07:43:05 -0400
Message-ID: <411CA947.8080408@blueyonder.co.uk>
Date: Fri, 13 Aug 2004 12:43:03 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: Two problems with 2.6.8-rc4-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 13 Aug 2004 11:43:26.0226 (UTC) FILETIME=[BEC2BF20:01C4812A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ismail dönmez wrote:
Hi all,

 > I am having some problems with 2.6.8-rc4-mm1
 >
 > 1- In syslog I am getting messages like :
 >
 > Probing IDE interface ide0...
 > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 > Probing IDE interface ide1...
 > ide1 at 0x170-0x177,0x376 on irq 15
 > Probing IDE interface ide2...
 > ide2: Wait for ready failed before probe !
 > Probing IDE interface ide3...
 > ide3: Wait for ready failed before probe !
 > Probing IDE interface ide4...
 > ide4: Wait for ready failed before probe !
 > Probing IDE interface ide5...
 > ide5: Wait for ready failed before probe !
 >
 > 2- Penguin logo doesn't show up in console though framebuffer is enabled.
 >
 > Any ideas?
Nothing to worry about for the first question, see 
/usr/src/linux-2.6.8-rc4-mm1/Documentation/ide.txt for an explanation, 
it probes ide0-5 by default.
Regards
Sid.

--
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====

