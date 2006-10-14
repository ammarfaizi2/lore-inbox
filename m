Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWJNKz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWJNKz4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 06:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbWJNKz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 06:55:56 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:14854 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1752148AbWJNKzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 06:55:55 -0400
Message-ID: <4530C237.6050809@argo.co.il>
Date: Sat, 14 Oct 2006 12:55:51 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Ryan Richter <ryan@tau.solarneutrino.net>
CC: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Intel 965G: i915_dispatch_cmdbuffer failed (2.6.19-rc2)
References: <20061013194516.GB19283@tau.solarneutrino.net>
In-Reply-To: <20061013194516.GB19283@tau.solarneutrino.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Oct 2006 10:55:53.0322 (UTC) FILETIME=[517624A0:01C6EF7F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Richter wrote:
>
> I have a new Intel 965G board, and I'm trying to get DRI working.
> Direct rendering is enabled, but all GL programs crash immediately.
> The message 'DRM_I830_CMDBUFFER: -22' is printed on the tty, and the
> kernel says:
>
> [drm:i915_cmdbuffer] *ERROR* i915_dispatch_cmdbuffer failed
>

I had the same problem.  Recompiling i965_dri.so in order to insert 
debugging code "fixed" it for me.  It continued working  after a mesa 
package update so I assumed it was a miscompilation.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

