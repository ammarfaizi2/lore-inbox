Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292639AbSCDSQO>; Mon, 4 Mar 2002 13:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292648AbSCDSQI>; Mon, 4 Mar 2002 13:16:08 -0500
Received: from AMontpellier-201-1-1-61.abo.wanadoo.fr ([193.252.31.61]:45320
	"EHLO awak") by vger.kernel.org with ESMTP id <S292639AbSCDSPn> convert rfc822-to-8bit;
	Mon, 4 Mar 2002 13:15:43 -0500
Subject: Re: [2.4.19-pre1-ac1] usbnet frames mangled
From: Xavier Bestel <xavier.bestel@free.fr>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020304174939.GB3267@kroah.com>
In-Reply-To: <1015003428.2274.5.camel@bip>
	<20020302071545.GB20536@kroah.com> <1015073017.777.0.camel@bip> 
	<20020304174939.GB3267@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 04 Mar 2002 19:15:34 +0100
Message-Id: <1015265735.3055.3.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le lun 04-03-2002 à 18:49, Greg KH a écrit :
> On Sat, Mar 02, 2002 at 01:43:36PM +0100, Xavier Bestel wrote:
> > le sam 02-03-2002 à 08:15, Greg KH a écrit :
> > > On Fri, Mar 01, 2002 at 06:23:48PM +0100, Xavier Bestel wrote:
> > > > 
> > > > which of course doesn't mean anything. I saw this behavior since I
> > > > upgraded my desktop from 2.4.18-ac2 to 2.4.19-pre1-ac1
> > > 
> > > So you kept your USB client at the same version, but your host changed
> > > versions?  And 2.4.18-ac2 works, but 2.4.19-pre1-ac1 doesn't?
> > 
> > That's it.
> > 
> > > Can you see if 2.4.19-pre2 works or not for you?
> > 
> > It works pretty well.
> 
> So you don't have a problem with 2.4.19-pre2?  Great :)

Err ... I just understood today the freeze problems I had are due to
USB, but didn't manage to produce a valid testcase yet.
Apparently, if I plug back my ipaq then modprobe usbnet, the desktop
hangs. If I modprobe first, it works well.

	Xav

