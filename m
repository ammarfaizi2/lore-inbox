Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267847AbUHPSLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267847AbUHPSLL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 14:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267837AbUHPSLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 14:11:11 -0400
Received: from serwer.tvgawex.pl ([212.122.214.2]:25742 "HELO
	mother.ds.pg.gda.pl") by vger.kernel.org with SMTP id S267847AbUHPSLC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 14:11:02 -0400
Date: Mon, 16 Aug 2004 20:11:10 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040816181110.GA29244@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0408120347290.1628-100000@hubble.stokkie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408120347290.1628-100000@hubble.stokkie.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 03:57:38AM +0200, Robert M. Stockmann wrote:
> Its indeed not straight forward to use cdrtools-2.0x together with
> kernel 2.6.x . As an aid for the user, i wrote a small HOWTO for using 
> cdrtools together with kernel 2.6, with special focus on retrieval
> of which device names to use. The small HOWTO can be found on :
> http://crashrecovery.org/oss-dvd/HOWTO-ossdvd.html


 Why it's not easy? I've compiled cdrecord from source dozen times
without problems, have used it with 2.4/2.5/2.6 kernels and never
had any problem.

 My /etc/defaults/cdrecord is:

#v+
CDR_FIFOSIZE=6m
CDR_SPEED=8
CDR_DEVICE=/dev/hdc
#v-

 And works fine with my
hdc: 8X4X32, ATAPI CD/DVD-ROM drive
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 8192kB Cache, DMA

 It seams that people don't have problems, but they create problems
for themselves.

-- 
Tomasz Torcz            There exists no separation between gods and men:
zdzichu@irc.-nie.spam-.pl   one blends softly casual into the other. 

