Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269386AbUJWAlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269386AbUJWAlf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 20:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269301AbUJWAho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:37:44 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:15843 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269386AbUJWAgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:36:55 -0400
Subject: Re: [PATCH] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
In-Reply-To: <874qkmtibt.fsf@sulphur.joq.us>
References: <1097272140.1442.75.camel@krustophenia.net>
	 <20041008145252.M2357@build.pdx.osdl.net>
	 <1097273105.1442.78.camel@krustophenia.net>
	 <20041008151911.Q2357@build.pdx.osdl.net>
	 <20041008152430.R2357@build.pdx.osdl.net> <87zn2wbt7c.fsf@sulphur.joq.us>
	 <20041008221635.V2357@build.pdx.osdl.net> <87is9jc1eb.fsf@sulphur.joq.us>
	 <20041009121141.X2357@build.pdx.osdl.net> <878yafbpsj.fsf@sulphur.joq.us>
	 <20041009155339.Y2357@build.pdx.osdl.net>  <874qkmtibt.fsf@sulphur.joq.us>
Content-Type: text/plain
Date: Fri, 22 Oct 2004 20:36:49 -0400
Message-Id: <1098491810.1440.64.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 18:59 -0500, Jack O'Quin wrote:
> Chris Wright <chrisw@osdl.org> writes:
> 
> > - less generic variable names
> >   - s/any/rt_any/
> >   - s/gid/rt_gid/
> >   - s/mlock/rt_mlock/
> 
> Is there a compelling reason for changing all the parameter names?
> 
> I would prefer not to do that.  It is incompatible for our current
> user base, and really does not seem like an improvement.  Those names
> only appear in the context of `realtime', so the `rt_' is completely
> redundant.  For example...

I think the reason was to make the code more readable.  How about just
mapping the parameters to internal names by prepending rt_?

Lee 

