Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751867AbWAEDDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbWAEDDk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 22:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbWAEDDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 22:03:40 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:60072 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751867AbWAEDDj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 22:03:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TQc92oHaQgj6DKYDf9PvhOsSt3y+imLaSmE4PYIeIAFWWjBrQEzd5aYF3KcqjUCaSeR6mcbxRFIS7Jrytz3+fjY4m9A2293iOR15KXzSrR6cjLqlujqpiB0J5jFjpuxxxhPM67jkve+VzxI/ioCRE/G5MgU2FZk89xMhNGnkhI0=
Message-ID: <7e5f60720601041903s3462bf9bib9ada16fe70ef988@mail.gmail.com>
Date: Thu, 5 Jan 2006 04:03:18 +0100
From: Peter Bortas <bortas@gmail.com>
To: Stefan Smietanowski <stesmi@stesmi.com>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Cc: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Adrian Bunk <bunk@stusta.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Takashi Iwai <tiwai@suse.de>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <43BB9A0B.3010209@stesmi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601031522.06898.s0348365@sms.ed.ac.uk>
	 <s5hvex1m472.wl%tiwai@suse.de>
	 <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
	 <20060103215654.GH3831@stusta.de> <20060103221314.GB23175@irc.pl>
	 <20060103231009.GI3831@stusta.de>
	 <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl>
	 <43BB16C0.3080308@stesmi.com>
	 <Pine.BSO.4.63.0601040146540.29027@rudy.mif.pg.gda.pl>
	 <43BB9A0B.3010209@stesmi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, Stefan Smietanowski <stesmi@stesmi.com> wrote:

> So if I buy $COMMERCIAL_PROGRAM for say Solaris, AIX or anything else
> it REQUIRES me to download (before: buy) $COMMERCIAL_SOUNDSYSTEM?
>
> "In order to use this program you need to have OSS installed."
>
> That sounds insane to say the least.
>
> // Stefan

No. Everything on Solaris uses the Solaris native sound API except for
possibly quick-hack ports of applications from Linux. Doing anything
else would as you say be insane and break things like device
redirection on Sunrays.

--
Peter Bortas
