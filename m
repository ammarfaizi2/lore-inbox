Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269431AbTCDRRQ>; Tue, 4 Mar 2003 12:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269435AbTCDRRQ>; Tue, 4 Mar 2003 12:17:16 -0500
Received: from firewall.francoudi.net.32.27.217.in-addr.arpa ([217.27.32.7]:37995
	"EHLO news.linux.dom") by vger.kernel.org with ESMTP
	id <S269431AbTCDRRO>; Tue, 4 Mar 2003 12:17:14 -0500
To: linux-kernel@vger.kernel.org
From: Leonid Mamchenkov <f.l.linux-admin@news.francoudi.com>
Subject: Re: Updating the kernel of a RedHat 7.3
Date: Tue, 4 Mar 2003 17:27:32 +0000 (UTC)
Organization: Thunderworx Ltd.
Message-ID: <20030304172732.GA20620@francoudi.com>
References: <3E64DC09.C15CC287@tid.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
X-Trace: news.linux.dom 1046798852 16761 10.5.10.99 (4 Mar 2003 17:27:32 GMT)
X-Complaints-To: admins@news.francoudi.com
Content-Disposition: inline
In-Reply-To: <3E64DC09.C15CC287@tid.es>
X-Operating-System: Linux leonid.francoudi.com 2.4.18-19.8.0
X-Uptime: 7:16pm  up 36 days,  3:02, 11 users,  load average: 0.11, 0.08, 0.07
X-PGP-Public-Key: http://www.leonid.maks.net/leonid-at-francoudi.com.pub.key
User-Agent: Mutt/1.5.3i
Reply-To: Leonid Mamchenkov <leonid@francoudi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Miguel Gonz?lez Casta?os,

Once you wrote about "Updating the kernel of a RedHat 7.3":
MGlCo>  I have followed the instructions of redhat of how to upgrade a kernel
MGlCo> downloading from the upgrades.redhat.com web page the corresponding
MGlCo> RPMs.

It looks like you haven't followed all instructions...

MGlCo>  I have downloaded the following RPMs for my fresh installation:
MGlCo>  kernel-2.4.18-24.7.x.i686.rpm
MGlCo>  kernel-source-2.4.18-24.7.x.i686.rpm
MGlCo>  kernel-smp-2.4.18-24.7.x.i686.rpm (since its a double proccesor box)

Sometimes you need a little more then that, like modutils, for example.

MGlCo>  I did the upgrade of the kernel-source RPM and had to use -ivh --nodeps
MGlCo> --force options to install the kernel and the kernel-smp RPMs.

Using either of --nodeps and --force is asking for troubles... not to
mention a combination of two.

MGlCo> 
MGlCo>  I noticed that the kernel progress bar only reached the 50%.

Bad sign.

MGlCo>  Everything seems to be fine, but what could be wrong or everything is
MGlCo> fine?

If you can run lilo without any complaints, I'd call it a pretty good
sign.  Otherwise, noone knows. :)

-- 
Best regards,
  Leonid Mamtchenkov, RHCE
  System Administrator
  Francoudi & Stephanou Ltd.

