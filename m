Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTLDKpN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 05:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTLDKpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 05:45:13 -0500
Received: from shark.pro-futura.com ([161.58.178.219]:31658 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S261305AbTLDKpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 05:45:10 -0500
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko@croadria.com>
To: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-ck1
Date: Thu, 4 Dec 2003 11:43:43 +0100
User-Agent: KMail/1.5.1
References: <200312040228.44980.kernel@kolivas.org>
In-Reply-To: <200312040228.44980.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312041143.43629.tvrtko@croadria.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 December 2003 16:28, Con Kolivas wrote:
> Updated my patchset.

There is something wrong with /proc/stat which confuses xosview and ksysguard 
regarding CPU usage. Top is working ok.

tvrtko@oxygene:~> cat /proc/stat
cpu  7452 0 2048 40426
cpu0 7452 0 2048 1844674407370950652
page 146199 106012
swap 1 0
intr 559574 499265 1318 0 0 0 0 1 673 2 0 0 3872 31224 0 23216 3 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
0 0 0 0 0 0
disk_io: (3,0):(23282,11382,292398,11900,212024)
ctxt 356071
btime 1070534465
processes 5491

