Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267901AbUHKDGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267901AbUHKDGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 23:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267899AbUHKDGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 23:06:41 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:28320 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267901AbUHKDGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 23:06:38 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Lee Revell <rlrevell@joe-job.com>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <yw1xllgm8quu.fsf@kth.se>
References: <1092082920.5761.266.camel@cube>
	 <cone.1092092365.461905.29067.502@pc.kolivas.org>
	 <1092099669.5759.283.camel@cube> <yw1xisbrflws.fsf@kth.se>
	 <1092148392.5818.6.camel@mindpipe>  <yw1xllgm8quu.fsf@kth.se>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1092193620.784.29.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 23:07:01 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 20:23, Måns Rullgård wrote:
> Lee Revell <rlrevell@joe-job.com> writes:
> 
> > On Tue, 2004-08-10 at 04:16, Måns Rullgård wrote:
> >> Another option would be an Alt-Sysrq-something that lowered all RT
> >> processes to normal levels.
> >
> >
> > If someone wants to code this up I and the other people on jackit-devel
> > would gladly test it.
> 
> Here you go.  Some limited testing suggests that it actually works.
> Pressing Alt-Sysrq-N (as in Nice) changes all RT tasks to SCHED_NORMAL
> policy.
> 

I sent this patch to the jackit-devel list, and everyone seems to think
this would be a useful feature; had this been around a few years ago it
certainly would have aided JACK's development.  Debugging an RT process
becomes as easy as a regular one (read: reboot free).  I see no reason
not to merge it once it has been widely tested.

Lee

