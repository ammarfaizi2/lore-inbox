Return-Path: <linux-kernel-owner+w=401wt.eu-S1754938AbWL1TMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938AbWL1TMJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 14:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754940AbWL1TMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 14:12:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49949 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754938AbWL1TMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 14:12:08 -0500
Date: Thu, 28 Dec 2006 14:12:04 -0500
From: Dave Jones <davej@redhat.com>
To: Rene Herman <rene.herman@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com
Subject: Re: [BUG 2.6.20-rc2] atkbd.c: Spurious ACK
Message-ID: <20061228191204.GB8940@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Rene Herman <rene.herman@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	dmitry.torokhov@gmail.com
References: <4592E685.5000602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4592E685.5000602@gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2006 at 10:32:53PM +0100, Rene Herman wrote:
 > Good day.
 > 
 > The bug where the kernel repetitively emits "atkbd.c: Spurious ACK on 
 > isa0060/serio0. Some program might be trying access hardware directly" 
 > (sic) on a panic, thereby scrolling away the information that would help 
 > in seeing what exactly the problem was (ie, "Unable to mount root fs" or 
 > something) is still present in 2.6.20-rc2.

Do you have a KVM ?  Quite a few of those seem to tickle this printk.

		Dave

-- 
http://www.codemonkey.org.uk
