Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270222AbTGWMFW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 08:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270230AbTGWMFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 08:05:21 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:520 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S270222AbTGWMFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 08:05:18 -0400
Subject: Re: root= needs hex in 2.6.0-test1-mm2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Tom Felker <tcfelker@mtco.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200307230156.40762.tcfelker@mtco.com>
References: <200307230156.40762.tcfelker@mtco.com>
Content-Type: text/plain
Message-Id: <1058962821.574.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 23 Jul 2003 14:20:21 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-23 at 08:56, Tom Felker wrote:
> I finally booted 2.6.0-test1-mm2, after reading somebody else who needed to 
> use hex in the root= argument.  root=/dev/hdb1 and root=hdb2 would panic 
> ("VFS: Cannot open root device hdb1 or unknown-block(0,0)"), but root=0341 
> worked.  Devfs is compiled in, devfs=nomount and devfs=mount make no 
> difference.  Is this intentional?

I would say it's a bug :-)

