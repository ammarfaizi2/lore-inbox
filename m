Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWE1T4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWE1T4A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 15:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWE1T4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 15:56:00 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:906 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750871AbWE1Tz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 15:55:59 -0400
Subject: Re: How to check if kernel sources are installed on a system?
From: Lee Revell <rlrevell@joe-job.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
       devmazumdar <dev@opensound.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1148839964.3074.52.camel@laptopd505.fenrus.org>
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe>
	 <1148653797.3579.18.camel@laptopd505.fenrus.org>
	 <20060528130320.GA10385@osiris.ibm.com>
	 <1148835799.3074.41.camel@laptopd505.fenrus.org>
	 <1148838738.21094.65.camel@mindpipe>
	 <1148839964.3074.52.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sun, 28 May 2006 15:55:29 -0400
Message-Id: <1148846131.27461.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-28 at 20:12 +0200, Arjan van de Ven wrote:
> Also... why would there really be a need for such a way? Not for
> building anything for sure.... it's for the human. And the human seems
> to just find it already (and again the boot file works well in practice
> it seems)
> 

Debugging.  When a new Linux user files a "no sound" ALSA bug report I
need to find out whether they have any known broken options enabled,
like USB bandwidth checking or the OSS USB midi/audio drivers.  If we
have to go back and forth figuring out which distro they have and where
the config is they are that much more likely to give up and go back to
Windows.

Lee

