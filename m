Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVDEXIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVDEXIG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 19:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVDEXIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 19:08:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52416 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261977AbVDEXIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 19:08:01 -0400
Message-ID: <42531A42.90508@pobox.com>
Date: Tue, 05 Apr 2005 19:07:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Stromberg <strombrg@dcs.nac.uci.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: AOE and large filesystems?
References: <pan.2005.04.05.20.44.39.37209@dcs.nac.uci.edu>
In-Reply-To: <pan.2005.04.05.20.44.39.37209@dcs.nac.uci.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Stromberg wrote:
> Some questions for the list:
> 
> 1) Is anyone on the list using AOE in production?
> 
> 2) Is anyone on the list using AOE in combination with md and/or LVM2?
> 
> 3) Is anyone on the list using AOE on a 64 bit platform?

While I think AoE is "neat", IMO you really want to use something based 
on TCP, even on a LAN...

Your CPU usage w/ zerocopy offload could potentially be lowered w/ TCP, 
in addition to the built-in reliability.

As a tangent, I'd also like to see iSCSI over SCTP.

	Jeff



