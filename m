Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTIELKa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 07:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbTIELKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 07:10:30 -0400
Received: from zinc.btinternet.com ([194.73.73.148]:1447 "EHLO
	zinc.btinternet.com") by vger.kernel.org with ESMTP id S262439AbTIELK2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 07:10:28 -0400
From: Nick Sanders <sandersn@btinternet.com>
To: Jan Ischebeck <mail@jan-ischebeck.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm6
Date: Fri, 5 Sep 2003 12:10:25 +0100
User-Agent: KMail/1.5.3
References: <1062758896.2085.19.camel@JHome.uni-bonn.de>
In-Reply-To: <1062758896.2085.19.camel@JHome.uni-bonn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309051210.25773.sandersn@btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> 3. The oss mixer emulation doesn't load correctly, I get the following
> messages in the syslog, f.e. after a "modprobe snd-mixer-oss":
>
> snd: Unknown parameter `device_mode'

I had to remove the device_mode option from below in /lib/modules/
modprobe.conf. It happens in test4 too i think.

options snd major=116 cards_limit=4 device_mode=0660

