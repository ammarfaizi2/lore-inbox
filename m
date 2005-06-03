Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVFCTzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVFCTzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 15:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVFCTzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 15:55:46 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:43991 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261422AbVFCTzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 15:55:39 -0400
Message-ID: <42A0B5BC.8050205@blueyonder.co.uk>
Date: Fri, 03 Jun 2005 20:55:40 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc5/2.6.12-rc5-git8 USB problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jun 2005 19:56:18.0106 (UTC) FILETIME=[4E6C09A0:01C56876]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everything works OK on 2.6.12-rc4. The joysticks are seen by lsusb and 
the joystick test programs, but the controls do nothing in 2.6.12-rc5 
and 2.6.12-rc5-git8.
# js_demo
Joystick test program.
~~~~~~~~~~~~~~~~~~~~~~
Joystick 0: "CH PRODUCTS CH FLIGHT SIM YOKE USB "
Joystick 1: "CH PRODUCTS CH PRO PEDALS USB "

# jscal /dev/js0
Joystick has 7 axes and 13 buttons.
Correction for axis 0 is broken line, precision is 0.
Coeficients are: 127, 127, 5534751, 5534751
Correction for axis 1 is broken line, precision is 0.
Coeficients are: 127, 127, 5534751, 5534751
Correction for axis 2 is broken line, precision is 0.
Coeficients are: 127, 127, 5534751, 5534751
Correction for axis 3 is broken line, precision is 0.
Coeficients are: 127, 127, 5534751, 5534751
Correction for axis 4 is broken line, precision is 0.
Coeficients are: 127, 127, 5534751, 5534751
Correction for axis 5 is broken line, precision is 0.
Coeficients are: 0, 0, 536870912, 536870912
Correction for axis 6 is broken line, precision is 0.
Coeficients are: 0, 0, 536870912, 536870912

Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Keen licensed Private Pilot
Retired IBM Mainframes and Sun Servers Tech Support Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks
