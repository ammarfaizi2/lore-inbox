Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUDTWbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUDTWbc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbUDTWaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:30:19 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:61418 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S264569AbUDTVjO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 17:39:14 -0400
Message-ID: <40859891.8080208@dlfp.org>
Date: Tue, 20 Apr 2004 23:39:29 +0200
From: matthieu <mat_@dlfp.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: pts having the same device number.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
on 2.6.4 I have seen that two pts device can have the same number :
$ls -l /dev/pts/
total 0
crw--w----    1 mat      tty      136,   2 2004-04-20 23:15 2562
crw--w----    1 mat      tty      136,   2 2004-04-20 23:15 2818

Is that normal ?
