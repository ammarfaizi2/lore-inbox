Return-Path: <linux-kernel-owner+w=401wt.eu-S1030303AbWL3TSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbWL3TSp (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 14:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWL3TSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 14:18:45 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:3943 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030303AbWL3TSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 14:18:44 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: No sound in KDE with intel hda since 2.6.20-rc1
Date: Sat, 30 Dec 2006 19:19:06 +0000
User-Agent: KMail/1.9.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-sound@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
       PeiSen Hou <pshou@realtek.com.tw>
References: <200612301844.02413.s0348365@sms.ed.ac.uk> <20061230191123.GA4352@mellanox.co.il>
In-Reply-To: <20061230191123.GA4352@mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612301919.06949.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 December 2006 19:11, Michael S. Tsirkin wrote:
> > On Friday 29 December 2006 06:25, Michael S. Tsirkin wrote:
> > > Virtual MIDI Card 1
> >
> > Compile this feature out, I bet things start working again.
>
> Yes, this helped, thanks.
> BTW, is this expected?

It's a severe "misfeature" in my opinion that caused me problems years ago. 
The first soundcard becomes "default", which can probably be overridden in 
many different ways.

However, I really think a hack should be put in to prevent "virtual MIDI" from 
ever being in the first slot, it's just a bug asking to happen.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
