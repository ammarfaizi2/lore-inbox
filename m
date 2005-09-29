Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVI2OkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVI2OkP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 10:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVI2OkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 10:40:14 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:10113 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S932164AbVI2OkN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 10:40:13 -0400
Date: Thu, 29 Sep 2005 16:40:33 +0200
From: DervishD <lkml@dervishd.net>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writer is burning with open tray
Message-ID: <20050929144033.GA663@DervishD>
Mail-Followup-To: Karel Kulhavy <clock@twibright.com>,
	linux-kernel@vger.kernel.org
References: <20050929141924.GA6512@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050929141924.GA6512@kestrel>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Karel :)

 * Karel Kulhavy <clock@twibright.com> dixit:
> Then I repeated the same command (press up and enter) and it
> 1) Burned two bad CD's with a strip near the central area
> 2) Third CD burned bad
> 3) When rerun cdrecord says
> cdrecord: Drive does not support TAO recording.
> cdrecord: Illegal write mode for this drive.

    Your writer doesn't seem to work good with cdrecord...

> Is it possible to get eye damage due to faulty kernel driver?

    First, CD recording doesn't have to do directly with the kernel.
AFAIK, the kernel driver just passes commands to the device, is the
userspace app which generates the commands.

    Second, your writer looks faulty, although the problem may be a
simple incompatibility between the device and cdrecord.

    Third, not, you cannot get eye damage due to a faulty kernel
driver, but is possible to get eye damage if you look directly to a
laser. No matter if you use Linux or not.

> Is it possible to destroy the mechanics by overheating or mechanical
> damage due to faulty kernel driver?

    I don't think so. Better: I *hope* that my CD writer mechanics
can stand high temperatures without destroying, otherwise it won't
last long...
 
> Is this intended behaviour of Linux kernel?

    Do you think that the kernel designers want to create a good
source of coasters? My writer (Plextor) has burned almost 500 CD's
more or less, and I only have two coasters. Certainly both cdrecord
and the kernel seems to work quite good here. But my old CD writer, a
Philips 3610 (or something like that) did more or less what you tell
when it got broken.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
