Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270649AbTGNNHh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270624AbTGNNBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:01:00 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:50606 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S270671AbTGNM6j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:58:39 -0400
Message-ID: <3F12AD06.8070800@free.fr>
Date: Mon, 14 Jul 2003 15:15:50 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: linux 2.6-pre1 : make xconfig fails because "include/asm" rule is
 not called early enough
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wanted to give a try and immediately failed on this one.

HOSTCC scripts/fixdep
....
asm/socket.h: No such file or directory (no link for include/asm to 
include/asm-i386)

NOTE : calling "Make include/asm" and then xconfig works...

Not a problem, just annoying

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr

