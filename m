Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161218AbVKRVBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161218AbVKRVBW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161221AbVKRVBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:01:22 -0500
Received: from ctb-mesg5.saix.net ([196.25.240.85]:61614 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S1161218AbVKRVBV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:01:21 -0500
Message-ID: <437E40EA.2000508@telkomsa.net>
Date: Fri, 18 Nov 2005 23:00:26 +0200
From: Niel Lambrechts <unix@telkomsa.net>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [VFS] underlying mount-points
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

getwd() fails if the issuing user does not have access to the underlying 
mount-point of a particular directory.

Is there any way to acquire the underlying mount-point info 
(i-node/stat) after mounting a new one over it _without unmounting_ the 
new filesystem, or is the i-node information inaccessible until a umount 
occurs?

-Niel
