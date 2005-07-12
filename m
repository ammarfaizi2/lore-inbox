Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVGLAjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVGLAjQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 20:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbVGLAjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 20:39:16 -0400
Received: from cicero1.cybercity.dk ([212.242.40.4]:25863 "EHLO
	cicero1.cybercity.dk") by vger.kernel.org with ESMTP
	id S262294AbVGLAiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 20:38:55 -0400
Message-ID: <42D31136.90208@molgaard.org>
Date: Tue, 12 Jul 2005 02:39:18 +0200
From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PS/2 mouse not working
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I can't seem to get a new PS/2 mouse to give any input on 2.6.11.6. I 
have tried creating /dev/input/{mouse0,mouse1} apart from 
/dev/input/mice as per numbers in Documentation/devices.txt, and cat 
<device> gives no output when wiggling the mouse.

I have tried compiling psmouse as module and loading it, and I have 
tried compiling it into kernel. I have also chosen to have a /dev/psaux, 
that doesn't get any input either. Mouse seems to get detected, as per 
this snippet from dmesg:

...
mice: PS/2 mouse device common for all mice
...
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
...

Best regards,

Sune Mølgaard

-- 
Quitting vi is the most important command of that editor, and should be 
bound to something easy to type and available in all modes, for example 
the space bar.
- Per Abrahamsen
