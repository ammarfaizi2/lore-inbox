Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264904AbUGHSwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264904AbUGHSwg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 14:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264909AbUGHSwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 14:52:36 -0400
Received: from gate.crashing.org ([63.228.1.57]:954 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264904AbUGHSwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 14:52:35 -0400
Subject: Re: ethernet support on ibook G4 differs from 2.4 to 2.6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: axel.azerty@netcourrier.com
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <mnet3.1089300645.12400.axel.azerty@netcourrier.com>
References: <mnet3.1089300645.12400.axel.azerty@netcourrier.com>
Content-Type: text/plain
Message-Id: <1089312572.5355.55.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 08 Jul 2004 13:49:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-08 at 12:30, axel.azerty@netcourrier.com wrote:
> Hello
> I have a little problem with ethernet support on an Apple ibook G4 and I m not sure it s a bug.
> Using linux 2.6 with the driver Sun GEM works fine without problem.
> Using the same driver (as the old is mentionned "OBSOLETE") in 2.4 doesn't work. dmesg doesn't mention it at all.
> Only the old "GMAC (G4/iBook ethernet) support (OBSOLETE, use Sun GEM)" works.
> 
> I ve attached my .config.
> 
> Please CC me, if someone answers, since I m not subscribed to the list.

The 2.4 version has not been updated for the new PCI IDs I suppose... the "old"
driver use a different probing mecanism based on open firmware that happen to
still work.

Ben.


