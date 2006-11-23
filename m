Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933385AbWKWJJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933385AbWKWJJw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 04:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933386AbWKWJJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 04:09:52 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:16535 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S933343AbWKWJJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 04:09:47 -0500
From: Dmitry Mishin <dim@openvz.org>
Organization: SWsoft
To: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [patch -mm] net namespace: empty framework
Date: Thu, 23 Nov 2006 12:07:40 +0300
User-Agent: KMail/1.9.4
Cc: Cedric Le Goater <clg@fr.ibm.com>, Daniel Lezcano <dlezcano@fr.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Eric W. Biederman" <ebiederm@xmission.com>, netdev@vger.kernel.org
References: <4563007B.9010202@fr.ibm.com> <200611221955.56942.dim@openvz.org> <20061123023943.GA22931@sergelap.austin.ibm.com>
In-Reply-To: <20061123023943.GA22931@sergelap.austin.ibm.com>
X-Face: 'h\woBm&GL5>q=4~&$7\8J0Sv3c2a98rBl,dx/@?L4)Tg!C-nz4]2>M>=?utf-8?q?6ZwpyJ=7Ek=7EqqVT-=0A=09=7CIm?=(,W)U}CZo`G#(&OpK?El5u#-mi~%Uo)?X/qE[LE-H88#x'Y<GId$mZ]i%"iG|<=?utf-8?q?Zm/4u=0A=09Ld=2E=23=5B/Am=7D=5DV10UW0qjZUu7?=@;6SQI%Uy^H
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611231207.40634.dim@openvz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 November 2006 05:39, Serge E. Hallyn wrote:
> Quoting Dmitry Mishin (dim@openvz.org):
> > On Wednesday 22 November 2006 19:41, Serge E. Hallyn wrote:
> > > Quoting Cedric Le Goater (clg@fr.ibm.com):
> > > > Hello,
> > > >
> > > > Dmitry Mishin wrote:
> > > > > This patch looks acceptable for us.
> > > >
> > > > good. shall we merge it then ? see comment below.
> > > >
> > > > > BTW, Daniel, we agreed to be based on the Andrey's patchset. I do
> > > > > not see a reason, why Cedric force us to make some unnecessary work
> > > > > and move existent patchset over his interface.
> > > >
> > > > yeah it's a bit different from andrey's but not that much and it's
> > > > more in
> > >
> > > Where is Andrey's patch?
> >
> > This thread - http://thread.gmane.org/gmane.linux.network/42666
>
> Thanks, Dmitry.  Now I do recall seeing that before.
>
> That patchset appears to go part, but not all the way to fitting in with
> the existing namespaces.  For instance, you use exit_task_namespaces() for
> refcounting, but don't put the net_namespace in the nsproxy and use your
> own mechanism for unsharing.
>
> It really seems useful to have all the namespaces be consistent whenever
> practical, and I don't think your patchset would need much tweaking to
> fit onto Cedric's patch.  Am I missing a complicating factor?
No. I've already said, Cedric's patch is acceptable for us.


-- 
Thanks,
Dmitry.
