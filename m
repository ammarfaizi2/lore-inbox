Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264890AbUE0RED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbUE0RED (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 13:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264889AbUE0REC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 13:04:02 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:46830 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264890AbUE0RDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 13:03:25 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: David Johnson <dj@david-web.co.uk>
Subject: Re: Can't make XFS work with 2.6.6
Date: Thu, 27 May 2004 13:03:15 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200405271736.08288.dj@david-web.co.uk>
In-Reply-To: <200405271736.08288.dj@david-web.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405271303.15932.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 27, 2004 12:36 pm, David Johnson wrote:
> XFS is compiled in so it's not a module problem. Google says this error is
> usually caused by passing the wrong root parameter to the kernel, but I'm
> definitely giving the right root device.

Are you sure?  Make sure the device names haven't changed between your 2.4 and 
2.6 kernels.  This can happen if a new driver is compiled in that causes them 
to be reordered, or for other reasons.  XFS has been working fine in 2.6.6 
for me so far...

Jesse
