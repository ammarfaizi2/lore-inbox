Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265523AbTFMUXP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 16:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265525AbTFMUXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 16:23:15 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:37131 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265523AbTFMUXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 16:23:13 -0400
Date: Fri, 13 Jun 2003 22:36:56 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: SCSI Write Cache Enable in 2.4.20?
Message-ID: <20030613203656.GB27043@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <A5974D8E5F98D511BB910002A50A66470B54CBA3@hdsmsx103.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A5974D8E5F98D511BB910002A50A66470B54CBA3@hdsmsx103.hd.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003, Cress, Andrew R wrote:

> IMO, it isn't "necessary", but it is very desirable, and should be the
> default, to disable write cache on SCSI disks for any system that is
> concerned about reliability.

The question was if Linux was up to using ordered tags between the
requests, which would allow to use the write cache safely.
