Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbUAISyM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 13:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbUAISyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 13:54:11 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:15634 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S263803AbUAISyI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 13:54:08 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: James Morris <jmorris@redhat.com>
Subject: Re: [PATCH][SELINUX] 3/7 Add node controls
Date: Fri, 9 Jan 2004 19:53:54 +0100
User-Agent: KMail/1.5.94
Cc: linux-kernel@vger.kernel.org
References: <Xine.LNX.4.44.0401091017250.21309-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0401091017250.21309-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401091953.54296.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 of January 2004 16:39, James Morris wrote:
> This patch against 2.6.1-mm2 adds 'node' access controls for SELinux,
> which allows network traffic to be controlled on the basis of remote
> address.
>
> Like the previous patch, similar functionality was present in earlier
> SELinux implementations; this is a rework within the constraints of the
> LSM hooks present in the mainline kernel.
But only for IPv4 right? What about IPv6 part - is SELinux able to deal with 
IPv6 at all?

> Please apply.

-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux
