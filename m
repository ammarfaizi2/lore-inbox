Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263128AbVGaAUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbVGaAUW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 20:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbVGaAUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 20:20:22 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:1959 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263128AbVGaAS1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 20:18:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HFwhRMLilkCf773w031CMgTyGBPw9qMlcdjI/wfTqDUXWZfVxEKv9/wXVOCxXgszKBDESfTV/9SB+PoFg33D8CF4kVvL6ata0+rcXP42uuWCVnZaRu5OiIwmfzpymuV2CMNCRw8Ci2GX5ul/bIqU+Bi7ubg4ZCLRZkF47IPoecY=
Message-ID: <1c1c8636050730171876e892eb@mail.gmail.com>
Date: Sun, 31 Jul 2005 12:18:23 +1200
From: mdew <some.nzguy@gmail.com>
Reply-To: mdew <some.nzguy@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ati-remote strangeness from 2.6.12 onwards
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

using 2.6.11 everything works fine, Upgrading too 2.6.13-rc3 I noticed 2 errors,

(1) When setting the HZ rating too 250 or 100 will cause the driver to
excessfully repeat keys/accelerate when pressing a button, making it
unusable :(

(2) the "Ok" button no longer works in anything after and including
2.6.12-rc1 (I've tested upto 2.6.13-rc3), 2.6.11 works fine. xbindkeys
doesnt register any "ok" key presses on 2.6.12-rc1 onwards.

2.6.11 xbindkeys responses (nothing shows up in -rc1)

mediabawx2:~# xbindkeys -mk
Press combination of keys or/and click under the window.
You can use one of the two lines after "NoCommand"
in $HOME/.xbindkeysrc to bind a key.

--- Press "q" to stop. ---
"NoCommand"
m:0x0 + c:36
Return
"NoCommand"
m:0x0 + c:36
Return


Thanks :)
