Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbVHZTI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbVHZTI4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbVHZTI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:08:56 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:20360 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP
	id S1030203AbVHZTIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:08:54 -0400
X-ORBL: [67.124.117.85]
Date: Fri, 26 Aug 2005 12:08:51 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Alan Jenkins <sourcejedi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050826190851.GB12296@taniwha.stupidest.org>
References: <1124996732.5848.9.camel@singularity.jenkins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124996732.5848.9.camel@singularity.jenkins>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 08:05:32PM +0100, Alan Jenkins wrote:

> I'm curious as to why the kernel has to include the decoder - why
> you can't just run a self-extracting executable in an empty
> initramfs (with a preset capacity if needs be).

You could do tht right now if you wished.

We just support decompression in the kernel because it's not overly
painful to do so (the code exists and works fairly well for the most
part).  The code to do so isn't ver large and it's marked __init too
(well, it should be).


