Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbUDEMbf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 08:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUDEMbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 08:31:35 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:51754 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262134AbUDEMbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 08:31:34 -0400
Message-ID: <40715203.8070004@blueyonder.co.uk>
Date: Mon, 05 Apr 2004 13:33:07 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: 2.6.5-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Apr 2004 12:31:33.0492 (UTC) FILETIME=[EE011340:01C41B09]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CC      arch/x86_64/kernel/setup.o
arch/x86_64/kernel/setup.c:258: warning: initialization from 
incompatible pointer type
arch/x86_64/kernel/setup.c: In function `setup_arch':
arch/x86_64/kernel/setup.c:411: error: `saved_command_line' undeclared 
(first use in this function)
arch/x86_64/kernel/setup.c:411: error: (Each undeclared identifier is 
reported only once
arch/x86_64/kernel/setup.c:411: error: for each function it appears in.)
make[1]: *** [arch/x86_64/kernel/setup.o] Error 1
make: *** [arch/x86_64/kernel] Error 2
-------------------------------------------------------------------
strlcpy(saved_command_line, early_command_line, COMMAND_LINE_SIZE);
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

