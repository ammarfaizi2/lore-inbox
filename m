Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbUGACjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUGACjU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 22:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUGACjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 22:39:20 -0400
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:61321 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S262756AbUGACjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 22:39:19 -0400
Message-ID: <40E37954.3080201@thinrope.net>
Date: Thu, 01 Jul 2004 11:39:16 +0900
From: Kalin KOZHUHAROV <kalin@thinrope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040627
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: How NOT to have already compiled modules (auto)load?
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the fuzzy subject, I couldn't formulate it better.

I was trying to find info on that on Google, man and Documentation/*, but to no avail...

I have a laptop with USB CD-ROM that is very rarely attached/used.
I have sr_mod, etc. compiled as modules.
On every boot it gets autoloaded, despite the fact that CD-ROM is not connected (no, I don't have another).

My question is is there any good(tm) way to prevent this?
One way I could think is to rename the module, but that is a bit bad.
Is there a way to blacklist some modules?

Or even better, to be able to manually modprobe (insmod) the so called blacklisted ones, but any other means to load them (such as dependency of another module, loaded by modprobe) should fail?

Another example is the ipv6, which is difficult to unload at best, as sometimes I want to test something without ipv6.

Any help and/or pointers are welcome!

I am subscribed here, please do NOT CC me for the sake of less traffic.

Kalin.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
