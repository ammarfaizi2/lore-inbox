Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVDLM1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVDLM1Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 08:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVDLMYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:24:35 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:59587 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S262381AbVDLMT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:19:27 -0400
Message-ID: <4258F74D.2010905@keyaccess.nl>
Date: Sun, 10 Apr 2005 11:52:13 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.12-rc2: Compose key doesn't work
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech.

I have mapped my right windows key to "Compose" in X:

Section "InputDevice"
         Identifier      "Keyboard0"
         Driver          "kbd"
         Option          "XkbModel" "pc104"
         Option          "XkbLayout" "us"
         Option          "XkbOptions" "compose:rwin"
EndSection

This worked fine upto  2.6.11.7, but doesn't under 2.6.12-rc2. The key 
doesn't seem to be doing anything anymore: "Compose-'-e" just gets me 
"'e" and so on.

X is X.org 6.8.1, keyboard is regular PS/2 keyboard, directly connected.

Rene.
