Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268049AbUHKMqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268049AbUHKMqJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 08:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268047AbUHKMpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 08:45:54 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:10961 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S268045AbUHKMpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 08:45:46 -0400
Message-ID: <411A14EF.1060502@eidetix.com>
Date: Wed, 11 Aug 2004 14:45:35 +0200
From: "David N. Welton" <davidw@eidetix.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Sascha Wilde <wilde@sha-bang.de>
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
References: <4107E788.8030903@eidetix.com> <41122C82.3020304@eidetix.com> <200408110131.14114.dtor_core@ameritech.net> <20040811122711.GA5759@ucw.cz>
In-Reply-To: <20040811122711.GA5759@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>>Could you please try the patch below? I am interested in tests both with
>>and without keyboard/mouse. The main idea is to leave ports that have been
>>disabled by BIOS alone... The patch compiles but otherwise untested. Against
>>2.6.7.

> Well, this has a problem - plugging a mouse later will never work, as
> the interface will be disabled by the BIOS if a mouse is not present at
> boot.

Nor does plugging a keyboard in work either.  On the other hand, for the 
application this computer is destined for, not being able to reboot is 
far, far worse than adding a mouse/keyboard at run time, so I'm happy. 
I'm still willing to work on and test patches, though, as I think it 
would be good to get some form of fix into the kernel.  And the fact 
that 2.4 works shows that it is possible...

-- 
David N. Welton
davidw@eidetix.com
