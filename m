Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbTIEMj2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 08:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbTIEMj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 08:39:28 -0400
Received: from mail.netbeat.de ([62.208.140.19]:41229 "HELO mail.netbeat.de")
	by vger.kernel.org with SMTP id S262575AbTIEMj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 08:39:26 -0400
Subject: Re: 2.6.0-test4-mm6
From: Jan Ischebeck <mail@jan-ischebeck.de>
To: Nick Sanders <sandersn@btinternet.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200309051210.25773.sandersn@btinternet.com>
References: <1062758896.2085.19.camel@JHome.uni-bonn.de>
	 <200309051210.25773.sandersn@btinternet.com>
Content-Type: text/plain
Message-Id: <1062765582.2081.3.camel@JHome.uni-bonn.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 05 Sep 2003 14:39:42 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr, 2003-09-05 um 13.10 schrieb Nick Sanders:
> >
> > 3. The oss mixer emulation doesn't load correctly, I get the following
> > messages in the syslog, f.e. after a "modprobe snd-mixer-oss":
> >
> > snd: Unknown parameter `device_mode'
> 
> I had to remove the device_mode option from below in /lib/modules/
> modprobe.conf. It happens in test4 too i think.
> 
> options snd major=116 cards_limit=4 device_mode=0660

Even if I remove the device_mode part I still get unresolved symbols
loading snd-oss-mixer.


-- 
Jan Ischebeck <mail@jan-ischebeck.de>

