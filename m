Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbVF3Sl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbVF3Sl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 14:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbVF3Sl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 14:41:56 -0400
Received: from 90.Red-213-97-199.pooles.rima-tde.net ([213.97.199.90]:14988
	"HELO fargo") by vger.kernel.org with SMTP id S262850AbVF3Sly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 14:41:54 -0400
Date: Thu, 30 Jun 2005 20:38:29 +0200
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: Robert Love <rml@novell.com>
Cc: John McCutchan <ttb@tentacle.dhs.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with inotify
Message-ID: <20050630183829.GB1108@fargo>
Mail-Followup-To: Robert Love <rml@novell.com>,
	John McCutchan <ttb@tentacle.dhs.org>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050630181824.GA1058@fargo> <1120156188.6745.103.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1120156188.6745.103.camel@betsy>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Jun 30 at 02:29:48, Robert Love wrote:
> > I just patched 2.6.12 kernel with the inotify latest patch
> > (inotify-0.23-rml-2.6.12-14.patch). Inotify is working ok with the test program
> > provided in inotify-utils but... I can no longer mount my IDE cdrom devices
> > :(. Each time i try to mount a disc, the mount proccess get stuck in D state. I
> > don't see what's the relation between inotify and IDE devices, but if i switch
> > back to the unpatched 2.6.12, mounting works again.
> 
> Very weird.

Indeed.

> Did everything work with an earlier inotify?

It's the first notify i've tested, so i cannot compare with previous versions.

> Does wchan show anything useful (ps -ewo user,pid,command,wchan)?

I have to reboot to test it. I'll do it and told you if i see anything
weird in wchan for the mount process.

> Does it mount successfully once, and then subsequent mounts get suck, or
> does even the first mount get stuck in D?

The first mount get stuck, and subsequent mounts too. I tried to mount my CD-writer
and after that my DVD-writer and i got two mount D processes.

Thanks for the quick answer ;)

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
