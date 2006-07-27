Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161059AbWG0NmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbWG0NmX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 09:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbWG0NmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 09:42:23 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:17386 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1161059AbWG0NmW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 09:42:22 -0400
Date: Thu, 27 Jul 2006 15:42:15 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: dean gaudet <dean@arctic.org>
Cc: adam radford <aradford@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 3ware disk latency?
Message-ID: <20060727134215.GT1703@fi.muni.cz>
References: <20060710141315.GA5753@fi.muni.cz> <Pine.LNX.4.64.0607260942110.22242@twinlark.arctic.org> <1153946249.13509.29.camel@localhost.localdomain> <Pine.LNX.4.64.0607261440470.4568@twinlark.arctic.org> <b1bc6a000607261507g663ad95cwcc4a2ae4622e0fa2@mail.gmail.com> <Pine.LNX.4.64.0607261959010.4568@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607261959010.4568@twinlark.arctic.org>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet wrote:
: On Wed, 26 Jul 2006, adam radford wrote:
: > 
: > Did you try setting /sys/class/scsi_host/hostX/cmd_per_lun to 256 / num_units
: > ?
: 
: hmm doesn't look like i can do this in 2.6.16.27:
: 
: # ls -l /sys/class/scsi_host/host0/cmd_per_lun
: -r--r--r-- 1 root root 0 Jul 26 19:58 /sys/class/scsi_host/host0/cmd_per_lun
: # echo 85 >!$
: echo 85 >/sys/class/scsi_host/host0/cmd_per_lun
: zsh: permission denied: /sys/class/scsi_host/host0/cmd_per_lun
: 
: it'll probably be sometime until i update this box past 2.6.16.x ... but 
: i'll keep it in mind and retry the experiment... thanks.

	2.6.17.7 also does not allow cmd_per_lun to be written.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> I will never go to meetings again because I think  face to face meetings <
> are the biggest waste of time you can ever have.        --Linus Torvalds <
