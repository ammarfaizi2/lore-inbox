Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbUFBMYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUFBMYJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 08:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUFBMYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 08:24:08 -0400
Received: from mail003.syd.optusnet.com.au ([211.29.132.144]:35800 "EHLO
	mail003.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262370AbUFBMWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 08:22:38 -0400
From: Con Kolivas <kernel@kolivas.org>
To: John Bradford <john@grabjohn.com>
Subject: Re: why swap at all?
Date: Wed, 2 Jun 2004 22:22:14 +1000
User-Agent: KMail/1.6.1
Cc: FabF <fabian.frederick@skynet.be>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
References: <E1BVIVG-0003wL-00@calista.eckenfels.6bone.ka-ip.net> <200406022142.52854.kernel@kolivas.org> <200406021222.i52CMViE000156@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200406021222.i52CMViE000156@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406022222.14136.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2004 22:22, John Bradford wrote:
> Quote from Con Kolivas <kernel@kolivas.org>:
> > Does this explain in coarse examples to the desktop users why ideal
> > systems shouldn't be swap disabled or swappiness=0 ?
>
> Yes, except in the case where you are processing a small, (relative to
> physical RAM), dataset, and not even touching all physical RAM.
>
> (I admit, this isn't really typical desktop usage, though).

Well there is no doubt that there are some unique scenarios where an 
algorithmic setting will not be as good as a single static setting; and 
that's why I put in the option of disabling the auto swappiness. I believe 
our proc settings in the kernel should not need to be adjusted for the 
majority of cases, though.

Con
