Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWCLUwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWCLUwh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 15:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWCLUwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 15:52:37 -0500
Received: from [81.2.110.250] ([81.2.110.250]:16836 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932197AbWCLUwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 15:52:37 -0500
Subject: Re: Hard disk sector remapping
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Moweon Lee <a287848@ece.hanyang.ac.kr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44123D38.60000@ece.hanyang.ac.kr>
References: <44123D38.60000@ece.hanyang.ac.kr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Mar 2006 20:58:28 +0000
Message-Id: <1142197108.20056.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2006-03-11 at 12:00 +0900, Moweon Lee wrote:
> When the HDD's sector remapping occurs?

On modern disks the disk handle it on a write error. ATA/IDE disks won't
bother to even tell you (except via SMART statistics) while SCSI will
sometimes bother to give you a corrected error report.

