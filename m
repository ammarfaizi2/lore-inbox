Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271921AbTGYEFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 00:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271922AbTGYEFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 00:05:37 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:11279 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S271921AbTGYEFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 00:05:32 -0400
Date: Fri, 25 Jul 2003 01:22:58 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel@vger.kernel.org
Subject: [2.4] cosmetic keyboard bug when ctrl was presses at boot.
Message-Id: <20030725012258.01800b1f.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,

When pressing one or but times right key CTRL (not left CTRL or others),
at the moment of the beginning of kernel, exactly after the
decompression of this and before extinguished of the key numlock (I
suppose that he is keyboard boot), when kernel finishes starting, the
keyboard responds as if this key was pressed, such as letters, numbers
not appears in console when clicked.

The solution is to touch some keys like ctrl, alt, shift simultaneusly
among others randomly and returns to respond normally.

this is expectable, or is bug?

The kernel is 2.4.21 and the same it happens with 2.4.22-pre , and with
other machines of my friends, not happens with 2.6.0-test1.

Thanks in advance, and sorry my english.

arrivederci, djgera

Here is mi config
http://www.vmlinuz.com.ar/slackware/kernel.config.djgera/config-2.4.21


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
