Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWAYWkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWAYWkO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWAYWkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:40:14 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:47368 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932190AbWAYWkM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:40:12 -0500
To: Diego Calleja <diegocg@gmail.com>
Cc: Ram Gupta <ram.gupta5@gmail.com>, mloftis@wgops.com, barryn@pobox.com,
       a1426z@gawab.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
References: <200601212108.41269.a1426z@gawab.com>
	<986ed62e0601221155x6a57e353vf14db02cc219c09@mail.gmail.com>
	<E3C35184F807ADEC2AD9E182@dhcp-2-206.wgops.com>
	<728201270601230705k25e6890ejd716dbfc393208b8@mail.gmail.com>
	<20060123162624.5c5a1b94.diegocg@gmail.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: where editing text is like playing Paganini on a glass harmonica.
Date: Wed, 25 Jan 2006 22:27:11 +0000
In-Reply-To: <20060123162624.5c5a1b94.diegocg@gmail.com> (Diego Calleja's
 message of "23 Jan 2006 15:27:21 -0000")
Message-ID: <87zmlkq6yo.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jan 2006, Diego Calleja wrote:
> El Mon, 23 Jan 2006 09:05:41 -0600,
> Ram Gupta <ram.gupta5@gmail.com> escribió:
> 
>> Linux also supports multiple swap files . But these are more
> 
> There're in fact a "dynamic swap" tool which apparently
> does what mac os x do: http://dynswapd.sourceforge.net/
> 
> However, I doubt the approach is really useful. If you need that much
> swap space, you're going well beyond the capabilities of the machine.

Well, to some extent it depends on your access patterns. The backup
program I use (`dar') is an enormous memory hog: it happily eats 5Gb on
my main fileserver (an UltraSPARC, so compiling it 64-bit does away with
address space sizing problems). That machine has only 512Mb RAM, so
you'd expect the thing would be swapping to death; but the backup
program's locality of reference is sufficiently good that it doesn't
swap much at all (and that in one tight lump at the end).

-- 
`Everyone has skeletons in the closet.  The US has the skeletons
 driving living folks into the closet.' --- Rebecca Ore
