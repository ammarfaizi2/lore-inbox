Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266566AbUGVPRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266566AbUGVPRJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 11:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266630AbUGVPRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 11:17:08 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:36815 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266566AbUGVPQZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 11:16:25 -0400
Subject: Re: [Q] claimed block devices
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: christophe.varoqui@free.fr
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1090489874.40ff8e1226ad0@imp6-q.free.fr>
References: <1090489874.40ff8e1226ad0@imp6-q.free.fr>
Content-Type: text/plain
Message-Id: <1090499383.17489.39.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Jul 2004 07:29:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-22 at 04:51, christophe.varoqui@free.fr wrote:
> Hello,
> 
> does somebody know how a userspace C-proggy can detect if a block device is
> claimed  ? Creating a device map over such devices will fail, so better not to
> try.

I believe trying to open the device with O_EXCL will fail if the device
is claimed.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

