Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbTAWHqU>; Thu, 23 Jan 2003 02:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbTAWHqU>; Thu, 23 Jan 2003 02:46:20 -0500
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:41133
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S264940AbTAWHqT> convert rfc822-to-8bit; Thu, 23 Jan 2003 02:46:19 -0500
Subject: Re: Problem with Qlogic 2200 and 2.4.20
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Thomas Tonino <ttonino@users.sf.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3E2EB962.9020503@users.sf.net>
References: <20030122094015$6b19@gated-at.bofh.it>
	 <3E2EB962.9020503@users.sf.net>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Organization: Digitalroadkill.net
Message-Id: <1043308435.8274.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 23 Jan 2003 01:53:56 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-22 at 09:31, Thomas Tonino wrote:
> Przemys³aw Maciuszko wrote:
> > Hello.
> > I have a strange problem with 2.4.20 (also 2.4.19) and Qlogic FC 2200.
> > 
> > The machine runs test news-server, so disk load is high.
> > After few minutes of running I get the following errors on console:
> > 
> > qlogifc0 : no handle slots, this should not happen
> > hostdata->queued is 19, in_ptr: 63
> > qlogifc0 : no handle slots, this should not happen
> > hostdata->queued is 19, in_ptr: 6a
> > qlogifc0 : no handle slots, this should not happen
> > hostdata->queued is 19, in_ptr: 70
> > 
> > and so on.
> 
> This is a long standing problem. Andrew Patterson gave a patch on the list:
> 
> http://groups.google.com/groups?selm=linux.scsi.1019759258.2413.1.camel%40lvadp.fc.hp.com

Just to chime in, are you using the qlogicfc driver that comes with the
kernel? If so, Try using qlogic's 6.01 driver set instead and see if
your problem goes away. I've had other problems, mostly stack related,
but I've since found my fixes and will be rolling another kernel into
production soon, but keeping that driver version. I've got qla2300's and
2200's using 6.01.

I believe the kernel driver is still based on 5.38 or less driver
version, which has problems like you're experiencing. 

--
GrandMasterLee
