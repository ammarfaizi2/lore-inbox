Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbUE0LBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUE0LBp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 07:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUE0LBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 07:01:45 -0400
Received: from nat-ph3-wh.rz.uni-karlsruhe.de ([129.13.73.33]:8320 "EHLO
	au.hadiko.de") by vger.kernel.org with ESMTP id S261904AbUE0LBo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 07:01:44 -0400
From: Jens =?iso-8859-1?q?K=FCbler?= <cleanerx@au.hadiko.de>
To: linux-kernel@vger.kernel.org
Subject: Re: nforce2 keeps crashing with 2.4.27pre3
Date: Thu, 27 May 2004 13:01:39 +0200
User-Agent: KMail/1.5.3
References: <200405261756.35333.cleanerx@au.hadiko.de> <20040526190735.A6244@electric-eye.fr.zoreil.com>
In-Reply-To: <20040526190735.A6244@electric-eye.fr.zoreil.com>
Cc: netdev@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200405271301.39344.cleanerx@au.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [r8169 dysfunction on 2.4.27-pre3]
> http://www.fr.zoreil.com/people/francois/misc/20040526-2.4.27-pre3-r8169.c-
>test.patch
> Please report further success/failure on netdev@oss.sgi.com

Hi

I have applied the patch and my system is now stable even when heavy network 
traffic appears. I enabled NAPI for the card. The network througput is still 
a bit low (~12MB/s) but I guess this is due to the unpatched endpoint which 
is also rtl8169 because bonnie told me both harddrives of the computers are 
capable of more than that.
System temperature dropped by 13° (from 55°) when idle for those interested in 
test results.

Thanx for help

Jens

