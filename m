Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbTLCPR2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 10:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbTLCPR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 10:17:28 -0500
Received: from h1ab.lcom.net ([216.51.237.171]:38793 "EHLO digitasaru.net")
	by vger.kernel.org with ESMTP id S264880AbTLCPQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 10:16:19 -0500
Date: Wed, 3 Dec 2003 09:16:12 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: wes schreiner <wes@infosink.com>
Cc: Takashi Iwai <tiwai@suse.de>, Adam Belay <ambx1@neo.rr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: vanilla 2.6.0-test11 and CS4236 card
Message-ID: <20031203151611.GE27034@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: wes schreiner <wes@infosink.com>,
	Takashi Iwai <tiwai@suse.de>, Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20031202170637.GD5475@digitasaru.net> <s5hsmk3ceia.wl@alsa2.suse.de> <20031202234432.GA14730@neo.rr.com> <s5hekvmcfi8.wl@alsa2.suse.de> <3FCDFA77.9090705@infosink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCDFA77.9090705@infosink.com>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From wes schreiner on Wednesday, 03 December, 2003:
>I tested a combination of Takashi's version of the patch to 
>drivers/pnp/card.c and Adam's patch to sound/isa/cs423x/cs4236.c applied 
>to 2.6.0-test11 and report success. This is on a Dell Precision 
>Workstation 410 which doesn't have a MPU device. The card has always 
>been detected fine by ISAPNP and now when I modpobe snd-cs4236 the 
>modules load just like they should. PCM output and input work fine. I 
>exercised the audio system by running, at various times, xmms, aplay, 
>alsamixer, and audacity and everything worked OK. No kernel-tainting 
>modules were loaded. I would be happy to test the final version of these 
>patches.

Sweet.  Stupid NVidia drivers.  Thanks for the help (I have exactly the
  same system).  I'll report back when I've recovered from NVidia driver's
  mess.  :)

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
"Asked by CollabNet CTO Brian Behlendorf whether Microsoft will enforce its
 patents against open source projects, Mundie replied, 'Yes, absolutely.'
 An audience member pointed out that many open source projects aren't
 funded and so can't afford legal representation to rival Microsoft's. 'Oh
 well,' said Mundie. 'Get your money, and let's go to court.' 
Microsoft's patents only defensive? http://swpat.ffii.org/players/microsoft
