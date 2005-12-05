Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbVLEFG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbVLEFG4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 00:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbVLEFG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 00:06:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61868 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750970AbVLEFGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 00:06:55 -0500
Date: Sun, 4 Dec 2005 21:06:41 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: <art@usfltd.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMART over USB - problem
Message-Id: <20051204210641.65d78a92.zaitcev@redhat.com>
In-Reply-To: <mailman.1133566262.17183.linux-kernel2news@redhat.com>
References: <mailman.1133566262.17183.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.7; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Dec 2005 17:28:42 -0600, "art" <art@usfltd.com> wrote:

> SMART over USB - problem
> 
> usb--------------------------------------------------------
> # smartctl -a -T verypermissive /dev/sde

Naturally you have to tell smartctl to pack SMART into SCSI with -d.
There's no single standard though, and your drive has to be able to
accept SMART-over-ATAPI (as opposed to ATA).

-- Pete
