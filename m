Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269558AbUJWBc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269558AbUJWBc1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269759AbUJWB3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 21:29:23 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:53963 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269558AbUJWB2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 21:28:16 -0400
Subject: Re: [PATCH] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
In-Reply-To: <87zn2erzvx.fsf@sulphur.joq.us>
References: <1097272140.1442.75.camel@krustophenia.net>
	 <20041008145252.M2357@build.pdx.osdl.net>
	 <1097273105.1442.78.camel@krustophenia.net>
	 <20041008151911.Q2357@build.pdx.osdl.net>
	 <20041008152430.R2357@build.pdx.osdl.net> <87zn2wbt7c.fsf@sulphur.joq.us>
	 <20041008221635.V2357@build.pdx.osdl.net> <87is9jc1eb.fsf@sulphur.joq.us>
	 <20041009121141.X2357@build.pdx.osdl.net> <878yafbpsj.fsf@sulphur.joq.us>
	 <20041009155339.Y2357@build.pdx.osdl.net> <874qkmtibt.fsf@sulphur.joq.us>
	 <87zn2erzvx.fsf@sulphur.joq.us>
Content-Type: text/plain
Date: Fri, 22 Oct 2004 21:27:58 -0400
Message-Id: <1098494878.4731.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 20:23 -0500, Jack O'Quin wrote:
> > Chris Wright <chrisw@osdl.org> writes:
> > 
> > > - less generic variable names
> > >   - s/any/rt_any/
> > >   - s/gid/rt_gid/
> > >   - s/mlock/rt_mlock/

OK for those of you not playing along at home, here is the latest
version of the realtime LSM with all Chris' fixes, as a patch against
2.6.9-mm1. 

http://krustophenia.net/realtime-lsm-2.6.9-mm1.patch

I think the only change still needed is to remove the sysctl stuff.

-- 
Lee Revell <rlrevell@joe-job.com>

