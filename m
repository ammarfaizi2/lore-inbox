Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263915AbTE3TRJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 15:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTE3TRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 15:17:09 -0400
Received: from smtp5.wanadoo.es ([62.37.236.237]:24962 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id S263915AbTE3TRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 15:17:08 -0400
Message-ID: <3ED7B12E.2090903@wanadoo.es>
Date: Fri, 30 May 2003 21:29:50 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re:Slocate/backup, big load on 2.4.X
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Trabinski wrote:

>I'm sorry for little off-topic, but I sure that's problem with kernel. :(
>I have machine with two psyhical Intel(R) Xeon(TM) CPU 2.66GHz (four
>logical CPU Hyperthreading, 4GB RAM + 4GB SWAP eth PRO/1000, 5x SEAGATE
>discs ST373453LW, Adaptec AIC79XX scsi controler).
>System is RH 8.0, 7129 users authenticated by LDAP-PAM)
>After 12 hours of reboot, when updatedb is running or backup via amanda,
>system "get" very high load, it's look like this:
>the problem is

the problem is a RH 8.0(9 has it too) nasty bug with utf-8
http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=69900

for me LANG=" " instead LANG="en_US.UTF-8" at /etc/sysconfig/i18n
made the system _a lot of lighter_. remember to use latest kernel 2.4.20-13.x

regards,
-- 
Software is like sex, it's better when it's bug free.

