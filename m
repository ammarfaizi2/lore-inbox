Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbUKSCsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbUKSCsr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 21:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbUKSCsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 21:48:12 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:4571 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261234AbUKSCji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 21:39:38 -0500
Message-ID: <419D5CE6.8030503@google.com>
Date: Thu, 18 Nov 2004 18:39:34 -0800
From: Edward Falk <efalk@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040324
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE ioctl documentation & a new ioctl
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all; let me introduce myself:  I'm the guy that does IDE sustaining 
for Google.

I'm getting ready to sit down and document the IDE ioctls.  Probably 
Documentation/hdio.txt or something like that.  Before I start though, 
is anybody already doing this?

And while I'm on the subject, we're getting ready to write a new hdio 
ioctl, an extension of HDIO_DRIVE_CMD.  The intent here is to be 
slightly more general-purpose than HDIO_DRIVE_CMD, with an eye to 
supporting the full set of SMART functionality.  Current plan is to have 
the user pass a struct containing a pointer to the argument list, a 
pointer to the data buffer, and a data buffer length value.  Consider 
this a design document; any comments and/or feature requests?

	-ed falk
	efalk@google.com
