Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266120AbUBCUg7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 15:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUBCUg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 15:36:59 -0500
Received: from 245.150.3.213.dial.bluewin.ch ([213.3.150.245]:11815 "EHLO
	earth") by vger.kernel.org with ESMTP id S266120AbUBCUg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 15:36:56 -0500
Message-ID: <40200681.5000209@altern.org>
Date: Tue, 03 Feb 2004 21:37:21 +0100
From: Jean Revertera <marv@altern.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: marv@altern.org
Subject: How to make "dead key" capslockable with kbd?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently trying to customize my keymap file, but I have a problem: 
I'cant make these damn "dead key" correctly capslockable.

As the manpage from keymaps say:
Each  keysym  may  be prefixed by a '+' (plus sign), in which case this
keysym is treated as a "letter" and therefore  affected  by  the  "Cap-
sLock"  the same way as by "Shift"

That's what I have in my keymap file:
[...]
keycode   7 = +dead_circumflex  six        notsign          
Control_asciicircum
        alt     keycode   7 = Meta_six
[...]
With this, when I press the key with keycode 7 and capslock is "on", the 
caracter "6" is effectively displayed. On the other hand, when capslock 
is turned "off", this same key displays immediatly (i.e: is no more a 
dead key):
^B
I load the keymap file with:
loadkeys file.kmap.gz
I'm running linux-2.6.1 on an up-to-date Debian Sid.

Could someone tell me how I can make this working ?

TIA !
