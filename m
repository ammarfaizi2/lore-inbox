Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266364AbUGKHAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266364AbUGKHAk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 03:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266454AbUGKHAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 03:00:40 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:10932 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S266364AbUGKHAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 03:00:37 -0400
Message-ID: <40F0E586.4040000@t-online.de>
Date: Sun, 11 Jul 2004 09:00:22 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a2) Gecko/20040709
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.7, amd64: PS/2 Mouse detection doesn't work 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: SyJhKsZD8eC8vLBobMcsBAUrmUU8Rnws6fCU+2Gg1QefMjOOQ6eY0f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Most of the times my mouse is detected as generic PS/2,
even though it is a Logitech. I have to reload the mousedev
and psmouse modules to make it work.

# grep -i mouse /var/log/kern.log
Jul 10 17:23:08 r101 kernel: input: PS/2 Generic Mouse on isa0060/serio1
Jul 10 17:23:08 r101 kernel: mice: PS/2 mouse device common for all mice
Jul 10 17:24:59 r101 kernel: input: PS/2 Generic Mouse on isa0060/serio1
Jul 10 17:24:59 r101 kernel: mice: PS/2 mouse device common for all mice
Jul 10 17:43:41 r101 kernel: input: PS2++ Logitech Mouse on isa0060/serio1
Jul 10 17:43:41 r101 kernel: mice: PS/2 mouse device common for all mice
Jul 10 17:46:59 r101 kernel: input: PS2++ Logitech Mouse on isa0060/serio1
Jul 10 17:47:00 r101 kernel: mice: PS/2 mouse device common for all mice
Jul 11 07:34:34 r101 kernel: input: PS/2 Generic Mouse on isa0060/serio1
Jul 11 07:34:34 r101 kernel: mice: PS/2 mouse device common for all mice
Jul 11 07:36:01 r101 kernel: input: PS/2 Generic Mouse on isa0060/serio1
Jul 11 07:36:01 r101 kernel: mice: PS/2 mouse device common for all mice
Jul 11 08:43:33 r101 kernel: mice: PS/2 mouse device common for all mice
Jul 11 08:43:33 r101 kernel: input: PS2++ Logitech Mouse on isa0060/serio1


Usually I wouldn't care, but I can go mad if the 4th mouse
button doesn't work :-).


Any idea?


Regards

Harri
