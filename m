Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbTB0HJc>; Thu, 27 Feb 2003 02:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbTB0HJc>; Thu, 27 Feb 2003 02:09:32 -0500
Received: from viefep15-int.chello.at ([213.46.255.19]:25882 "EHLO
	viefep15-int.chello.at") by vger.kernel.org with ESMTP
	id <S261463AbTB0HJa>; Thu, 27 Feb 2003 02:09:30 -0500
Subject: Re: About /etc/mtab and /proc/mounts
From: Joseph Wenninger <kernel@jowenn.at>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3E5DB2CA.32539D41@daimi.au.dk>
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk>
	<buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp> 
	<3E5DB2CA.32539D41@daimi.au.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 27 Feb 2003 08:07:16 +0100
Message-Id: <1046329637.1404.13.camel@jowennmobile>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Am Don, 2003-02-27 um 07.40 schrieb Kasper Dupont:
> Miles Bader wrote:
> > 
> > Kasper Dupont <kasperd@daimi.au.dk> writes:
> > > I don't think you can put all the information from /etc/mtab
> > > into /proc/mounts without breaking compatibility.
> > 

For KDE 3.1 I've written a mount watcher, which checks the modification
time of the /etc/mtab to recognize mount/unmount activity, which broke
for linux from scratch( for now, they have updated there install
instructions), because they linked to /proc/mounts, which doesn't seem
to support mtime. 
If the mtab is really completly removed, is there something else I can 
use to track mount activities from userspace ? I don't want to retrieve
the whole mounted list all the time and compare each entry to my
internally stored list, just to find out that nothing has changed
anyways.

Kind regards
Joseph Wenninger


