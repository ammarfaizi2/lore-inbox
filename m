Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271022AbTGQHLs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 03:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271026AbTGQHLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 03:11:48 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:10750 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S271022AbTGQHLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 03:11:47 -0400
Subject: Re: 2.6 sound drivers?
From: Martin Schlemmer <azarah@gentoo.org>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030716233045.GR2412@rdlg.net>
References: <20030716225826.GP2412@rdlg.net>
	 <20030716231029.GG1821@matchmail.com>  <20030716233045.GR2412@rdlg.net>
Content-Type: text/plain
Organization: 
Message-Id: <1058426808.1164.1518.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 17 Jul 2003 09:26:49 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-17 at 01:30, Robert L. Harris wrote:
> I do but the problem is I don't have a /dev/dsp, /dev/sound/dsp or
> anything else to point mpg123 at.
> 

On Thu, 2003-07-17 at 03:42, James H. Cloos Jr. wrote: 
> >>>>> "Robert" == Robert L Harris <Robert.L.Harris@rdlg.net> writes:
> 
> Robert> No go, it looks like it's playing but nothing to the speakers.
> 
> Alsa boots up muted.  Use alsamixer(1) (it is a curses app) to set
> your prefered volumes.  Then as root run 'alsactl store' to store
> said volumes.  Each boot running 'alsactl restore' will reset them.

Right.

Also, if you want /dev/sound/* you need to compile the OSS stuff
for ALSA ... 

  # modprobe snd-mixer-oss
  # modprobe snd-*-oss ....


-- 
Martin Schlemmer


