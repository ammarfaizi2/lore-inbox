Return-Path: <linux-kernel-owner+w=401wt.eu-S932095AbXAIOC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbXAIOC5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 09:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbXAIOC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 09:02:57 -0500
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:48145 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932095AbXAIOC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 09:02:56 -0500
Date: Tue, 9 Jan 2007 09:02:53 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Jeff Garzik <jeff@garzik.org>
cc: Avi Kivity <avi@qumranet.com>, kvm-devel <kvm-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [kvm-devel] [RFC] Stable kvm userspace interface
In-Reply-To: <45A39D0D.7090007@garzik.org>
Message-ID: <Pine.LNX.4.64.0701090901490.29287@d.namei>
References: <45A39A97.5060807@qumranet.com> <45A39D0D.7090007@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007, Jeff Garzik wrote:

> Can we please avoid adding a ton of new ioctls?  ioctls inevitably 
> require 64-bit compat code for certain architectures, whereas 
> sysfs/procfs does not.

I guess ioctl is not as important now if the API is now always talking to 
one VM.


- James
-- 
James Morris
<jmorris@namei.org>
