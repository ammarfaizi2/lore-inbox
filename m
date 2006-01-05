Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWAEJ6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWAEJ6F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 04:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbWAEJ6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 04:58:05 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:35349 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750871AbWAEJ6D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 04:58:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MCki8lVw9uHpyiChZ4+vnd3rJjLFUub2WddL+NQ1Us/MQ3HkQbFxuRB3t9Mf2I9dLAJb0qHa7gB8c+rkKZ76+yy6U5j8Fk9VNo96dG90mP/WqWu3ijxJfXHKIOoUp2bFsDQ9g2aMjfd8S/FCnGX6ZJ4srhN/vt/vWXnPaDdMqRQ=
Message-ID: <7e5f60720601050157p2e8e077eg45d6e666bb5ceeb6@mail.gmail.com>
Date: Thu, 5 Jan 2006 10:57:43 +0100
From: Peter Bortas <bortas@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Cc: Stefan Smietanowski <stesmi@stesmi.com>,
       =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Adrian Bunk <bunk@stusta.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Takashi Iwai <tiwai@suse.de>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0601050812040.10161@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601031522.06898.s0348365@sms.ed.ac.uk>
	 <20060103215654.GH3831@stusta.de> <20060103221314.GB23175@irc.pl>
	 <20060103231009.GI3831@stusta.de>
	 <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl>
	 <43BB16C0.3080308@stesmi.com>
	 <Pine.BSO.4.63.0601040146540.29027@rudy.mif.pg.gda.pl>
	 <43BB9A0B.3010209@stesmi.com>
	 <7e5f60720601041903s3462bf9bib9ada16fe70ef988@mail.gmail.com>
	 <Pine.LNX.4.61.0601050812040.10161@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> >No. Everything on Solaris uses the Solaris native sound API except for
> >possibly quick-hack ports of applications from Linux. Doing anything
> >else would as you say be insane and break things like device
> >redirection on Sunrays.
> >
> Device redirection is just "writing to a different /dev node" - on
> Solaris and Linux. IIRC, the API is the same.

Correct. Rederection to $AUDIODEVICE that is a normal /dev/audio.
