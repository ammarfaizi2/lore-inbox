Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271380AbTGQImO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 04:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271381AbTGQImO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 04:42:14 -0400
Received: from cm61.gamma179.maxonline.com.sg ([202.156.179.61]:31104 "EHLO
	hera.eugeneteo.net") by vger.kernel.org with ESMTP id S271380AbTGQImN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 04:42:13 -0400
Date: Thu, 17 Jul 2003 16:57:04 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 sound drivers?
Message-ID: <20030717085704.GA1381@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
References: <20030716225826.GP2412@rdlg.net> <20030716231029.GG1821@matchmail.com> <20030716233045.GR2412@rdlg.net> <1058426808.1164.1518.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058426808.1164.1518.camel@workshop.saharacpt.lan>
X-Operating-System: Linux 2.6.0-test1-mm1+o6int
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One thing I noticed abt this ALSA driver is that if I am playing
say, xmms at the moment, any additional sound output will be delayed
until I stop xmms. Is there any workaround? 

Using Intel(r) AC'97 Audio Controller - Sigmatel 9723 Codec

Eugene

<quote sender="Martin Schlemmer">
> On Thu, 2003-07-17 at 01:30, Robert L. Harris wrote:
> > I do but the problem is I don't have a /dev/dsp, /dev/sound/dsp or
> > anything else to point mpg123 at.
> > 
> 
> On Thu, 2003-07-17 at 03:42, James H. Cloos Jr. wrote: 
> > >>>>> "Robert" == Robert L Harris <Robert.L.Harris@rdlg.net> writes:
> > 
> > Robert> No go, it looks like it's playing but nothing to the speakers.
> > 
> > Alsa boots up muted.  Use alsamixer(1) (it is a curses app) to set
> > your prefered volumes.  Then as root run 'alsactl store' to store
> > said volumes.  Each boot running 'alsactl restore' will reset them.
> 
> Right.
> 
> Also, if you want /dev/sound/* you need to compile the OSS stuff
> for ALSA ... 
> 
>   # modprobe snd-mixer-oss
>   # modprobe snd-*-oss ....
> 
> 
> -- 
> Martin Schlemmer
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
