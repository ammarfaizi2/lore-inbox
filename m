Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVE0OwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVE0OwG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 10:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVE0OwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 10:52:06 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:984 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261780AbVE0OwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 10:52:02 -0400
Subject: Re: 2.6.12-rc3-mm3: ALSA broken ?
From: Lee Revell <rlrevell@joe-job.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
In-Reply-To: <1117151518l.7637l.0l@werewolf.able.es>
References: <20050504221057.1e02a402.akpm@osdl.org>
	 <1115510869l.7472l.0l@werewolf.able.es>
	 <1115594680l.7540l.0l@werewolf.able.es> <s5hd5rx2656.wl@alsa2.suse.de>
	 <1115936836l.8448l.1l@werewolf.able.es> <s5hvf5nsb2r.wl@alsa2.suse.de>
	 <1116331359l.7364l.0l@werewolf.able.es> <s5hll6eoxhf.wl@alsa2.suse.de>
	 <1116369585l.8840l.0l@werewolf.able.es> <s5hoeb8sleq.wl@alsa2.suse.de>
	 <1117151518l.7637l.0l@werewolf.able.es>
Content-Type: text/plain
Date: Fri, 27 May 2005 10:52:01 -0400
Message-Id: <1117205521.13829.59.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-26 at 23:51 +0000, J.A. Magallon wrote:
> - When linking I got:
> if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map
> 2.6.11-jam20; fi
> WARNING: /lib/modules/2.6.11-jam20/kernel/sound/soundcore.ko needs unknown
> symbol class_simple_device_add
> WARNING: /lib/modules/2.6.11-jam20/kernel/sound/soundcore.ko needs unknown
> symbol class_simple_destroy
> WARNING: /lib/modules/2.6.11-jam20/kernel/sound/soundcore.ko needs unknown
> symbol class_simple_device_remove
> WARNING: /lib/modules/2.6.11-jam20/kernel/sound/soundcore.ko needs unknown
> symbol class_simple_create
> WARNING: /lib/modules/2.6.11-jam20/kernel/sound/core/snd.ko needs unknown
> symbol class_simple_device_add
> WARNING: /lib/modules/2.6.11-jam20/kernel/sound/core/snd.ko needs unknown
> symbol class_simple_device_remove
> 
> I think all this have been unexported/killed...

Really?  I thought only unused EXPORT_SYMBOLS were being killed.

Lee

