Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSG1Lcf>; Sun, 28 Jul 2002 07:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315734AbSG1Lcf>; Sun, 28 Jul 2002 07:32:35 -0400
Received: from gusi.leathercollection.ph ([202.163.192.10]:17305 "EHLO
	gusi.leathercollection.ph") by vger.kernel.org with ESMTP
	id <S315721AbSG1Lce>; Sun, 28 Jul 2002 07:32:34 -0400
Date: Sun, 28 Jul 2002 19:35:36 +0800
From: Federico Sevilla III <jijo@free.net.ph>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-XFS Mailing List <linux-xfs@oss.sgi.com>
Subject: Re: Unkillable processes stuck in "D" state running forever
Message-ID: <20020728113536.GI1265@leathercollection.ph>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux-XFS Mailing List <linux-xfs@oss.sgi.com>
References: <20020728102246.GG1265@leathercollection.ph>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020728102246.GG1265@leathercollection.ph>
User-Agent: Mutt/1.4i
X-Organization: The Leather Collection, Inc.
X-Organization-URL: http://www.leathercollection.ph
X-Personal-URL: http://jijo.free.net.ph
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 06:22:46PM +0800, Federico Sevilla III wrote:
> I have been noticing problems on two of my boxes here with some
> processes somehow getting stuck in "D" state, which cannot be killed
> even by a SIGKILL by root, and stay on running forever. I have noticed
> the problem, so far, on 2.4.18-xfs and 2.4.19-rc2-xfs kernels.

I do not know how small a tidbit this will be, but together with these
processes stuck in state "D", there is a continuing rise in the load
averages of the system as reported by various interfaces
(top/uptime/w/phpSysInfo). On the system running 2.4.18-xfs this rose to
up to 25 before I eventually rebooted the box.

Another bit: on the 2.4.18-xfs box, the number of processes getting
stuck in state "D" kept growing. Various `ps ax` and `sync` processes in
particular, would get stuck and stall as I would issue them. It may be
interesting to note that with 2.4.19-rc2-xfs, with which I had my "latest
encounter" with this problem, no `ps ax` or `sync` processes got stuck.
Only the couple of apt-method processes that got stuck (and any new ones
I would launch in an attempt to download a package from the Internet for
installation) were there.

Both units have already been upgraded to 2.4.19-rc3-xfs. I will send
feedback if/when I run into any processes stuck in state "D" for
abnormally long periods of time.

 --> Jijo

-- 
Federico Sevilla III   :  <http://jijo.free.net.ph/>
Network Administrator  :  The Leather Collection, Inc.
GnuPG Key ID           :  0x93B746BE
