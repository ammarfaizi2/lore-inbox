Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVA2NCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVA2NCW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 08:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbVA2NCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 08:02:21 -0500
Received: from main.gmane.org ([80.91.229.2]:25312 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261395AbVA2NCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 08:02:18 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Richard Hughes <ee21rh@surrey.ac.uk>
Subject: Re: OpenOffice crashes due to incorrect access permissions on /dev/dri/card*
Date: Sat, 29 Jan 2005 13:02:51 +0000
Message-ID: <pan.2005.01.29.13.02.51.478976@surrey.ac.uk>
References: <pan.2005.01.29.10.44.08.856000@surrey.ac.uk> <E1CurmR-0000H8-00@calista.eckenfels.6bone.ka-ip.net> <pan.2005.01.29.12.49.13.177016@surrey.ac.uk>
Reply-To: ee21rh@surrey.ac.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host217-43-20-137.range217-43.btcentralplus.com
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2005 12:49:16 +0000, Richard Hughes wrote:
> Note, that strace glxgears gives exactly the same output, going from 0 to
> 14 and then seg-faulting, so it's *not just a oo problem*.

I know it's bad to answer your own post, but here goes.

I changed my /etc/udev/permissions.d/50-udev.permissions config to read:

dri/*:root:root:0666

changing it from 

dri/*:root:root:0660

And oowriter and glxgears work from bootup. Shall I file a bug with udev?

Richard Hughes

-- 

http://www.hughsie.com/PUBLIC-KEY


