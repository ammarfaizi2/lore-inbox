Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263208AbTDLJBK (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 05:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263209AbTDLJBK (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 05:01:10 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:56298 "EHLO
	iapetus.localdomain") by vger.kernel.org with ESMTP id S263208AbTDLJBJ (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 05:01:09 -0400
Date: Sat, 12 Apr 2003 11:13:17 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Simple Kernel-User Event Interface (Was: RE: [ANNOUNCE] udev 0.1 release)
Message-ID: <20030412091317.GA1542@iapetus.localdomain>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	"Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
	linux-kernel@vger.kernel.org
References: <A46BBDB345A7D5118EC90002A5072C780BEBAB1B@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780BEBAB1B@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.4i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 09:16:02PM -0700, Perez-Gonzalez, Inaky wrote:
> 
> The idea is you queue from the kernel a message and the user space
> reads it -entirely, no half things-, starting with a header (unsigned
> long size) and then the actual bytes. If the user provides a buffer

It would be better to use an ASCII interface using \n as event
separator. That's what I like about hotplug: it can be scripted.

-- 
Frank
