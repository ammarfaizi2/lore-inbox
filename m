Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbUAUVwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 16:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbUAUVwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 16:52:31 -0500
Received: from agminet02.oracle.com ([141.146.126.229]:19690 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S264245AbUAUVw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 16:52:29 -0500
Message-ID: <400EF356.3070007@oracle.com>
Date: Wed, 21 Jan 2004 22:47:02 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20040107
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.2-rc1 breaks Cisco VPN client 4.0.3.B
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-White-List-Member: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know cisco_ipsec is a binary module, but since 4.0.3.B works on
  any 2.4 and 2.6.{0,1} kernels I thought I'd report this...

On starting the VPN connection 'cvpnd' goes in D state, running
  ps axlw shows it's stuck in __down.

Oh, and reboot obviously hangs. I can Alt-SysRq Sync and Umount
  but I can't reboot - atkbd.c reports too many keys pressed. Eh ?
Funny, it's three keys just as in the S and U case. It doesn't
  seem to like the 'B' letter. I can 'O'ff it though.

If any kind soul is interested in digging further in this, I'm
  as usual available to try stuff out.


Thanks & ciao,

--alessandro

  "Two rivers run too deep
   The seasons change and so do I"
       (U2, "Indian Summer Sky")

