Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424553AbWKKLti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424553AbWKKLti (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 06:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424554AbWKKLti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 06:49:38 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:45737 "EHLO
	mo-p07-ob.rzone.de") by vger.kernel.org with ESMTP id S1424553AbWKKLth
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 06:49:37 -0500
Date: Sat, 11 Nov 2006 12:44:36 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wanted: more informative message if root device can't be found/mounted
Message-ID: <20061111114436.GA10020@aepfle.de>
References: <20061111085200.GA4167@amd64.of.nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061111085200.GA4167@amd64.of.nowhere>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, jurriaan wrote:

> kernel panic - unable to mount root device 09:02

These numbers are the root cause.
Use mount by filesystem UUID. On-disk content does unlikely change.
And if it does, you have to reconfigure the bootloader anyway.

All this luxury doesnt belong into the kernel.
