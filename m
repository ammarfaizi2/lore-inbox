Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269210AbUI3AP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269210AbUI3AP5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 20:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269218AbUI3AP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 20:15:56 -0400
Received: from serio.al.rim.or.jp ([202.247.191.123]:60058 "EHLO
	serio.al.rim.or.jp") by vger.kernel.org with ESMTP id S269210AbUI3APw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 20:15:52 -0400
Message-ID: <415B5034.6060809@yk.rim.or.jp>
Date: Thu, 30 Sep 2004 09:15:48 +0900
From: Chiaki <ishikawa@yk.rim.or.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: FSCK message suppressed during booting? (2.6.9-rc2)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using 2.6.9-rc2.
I had a hard hung (only Alt-SysReq-b helped me in recovering.).
Anyway, during the rebooting and expecting fsck run,
I had this very uncomfortable experience of
fsck message not displayed at all.

That is, under previous 2.4.xx kernel, I would have gotten
"The disk was not unmounted cleanly. Running fsck." or
some such message and fsck printed its
progress bar using ASCII characters.

But this message was not shown at all and
fsck seemed to have run without any message at all.

This is very disturbing to a home user.
I wish that this fsck message is restored
and visible during booting.
Since I was testing the release candidate version,
when I didn't see the fsck message and yet hear
the disk head moving around, I was afraid that something
amiss was happening and RESET the pc box and
rebooted in 2.4.2x kernel and made sure fsck run
to completeion with its visible message lines.

(Maybe somebody decided to hide the fsck messages
for users with thousands of disks attached?
I am not sure if this is a good idea to disable the
message by default.)


Please cc: me if you need a response from me.
I am not subscribed to LKML.

-- 
int main(void){int j=2003;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz";
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */
