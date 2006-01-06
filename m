Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWAFB3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWAFB3N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 20:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWAFB3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 20:29:13 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:23955 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1751153AbWAFB3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 20:29:11 -0500
Date: Thu, 5 Jan 2006 17:28:59 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Bernd Eckenfels <be-news06@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: oops pauser. / boot_delayer
In-Reply-To: <Pine.LNX.4.61.0601050905250.10161@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.62.0601051726290.973@qynat.qvtvafvgr.pbz>
References: <E1EuPZg-0008Kw-00@calista.inka.de> <Pine.LNX.4.61.0601050905250.10161@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, Jan Engelhardt wrote:

> Also note that the kernel generates a lot of noise^W text - if now the
> start scripts from $YOUR_FAVORITE_DISTRO also fill up, I can barely reach
> the top of the kernel when it says
>  Linux version 2.6.15 (jengelh@gwdg-wb04.gwdg.de) (gcc version 4.0.2
>  20050901 (prerelease) (SUSE Linux)) #1 Tue Jan 3 09:21:27 CET 2006

enable a few different types of encryption and you have to enlarge the 
buffer (by quite a bit). the fact that all the encryption tests print 
several lines each out and can't be turned off (short of a quiet boot 
where you loose everything) is one of the more annoying things to me right 
now.

this large boot message issue also slows your boot significantly if you 
have a fast box that has a serial console, it takes a long time to dump 
all that info out the serial port.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

