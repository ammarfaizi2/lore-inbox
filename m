Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264588AbTLCPAO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 10:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264589AbTLCPAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 10:00:14 -0500
Received: from mpls-qmqp-03.inet.qwest.net ([63.231.195.114]:61965 "HELO
	mpls-qmqp-03.inet.qwest.net") by vger.kernel.org with SMTP
	id S264588AbTLCPAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 10:00:09 -0500
Date: Wed, 03 Dec 2003 09:00:07 -0600
Message-ID: <3FCDFA77.9090705@infosink.com>
From: "wes schreiner" <wes@infosink.com>
To: "Takashi Iwai" <tiwai@suse.de>
Cc: "Adam Belay" <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en
MIME-Version: 1.0
Subject: Re: vanilla 2.6.0-test11 and CS4236 card
References: <20031202170637.GD5475@digitasaru.net>	<s5hsmk3ceia.wl@alsa2.suse.de>	<20031202234432.GA14730@neo.rr.com> <s5hekvmcfi8.wl@alsa2.suse.de>
In-Reply-To: <s5hekvmcfi8.wl@alsa2.suse.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested a combination of Takashi's version of the patch to 
drivers/pnp/card.c and Adam's patch to sound/isa/cs423x/cs4236.c applied 
to 2.6.0-test11 and report success. This is on a Dell Precision 
Workstation 410 which doesn't have a MPU device. The card has always 
been detected fine by ISAPNP and now when I modpobe snd-cs4236 the 
modules load just like they should. PCM output and input work fine. I 
exercised the audio system by running, at various times, xmms, aplay, 
alsamixer, and audacity and everything worked OK. No kernel-tainting 
modules were loaded. I would be happy to test the final version of these 
patches.

wes schreiner

