Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266898AbTAOTCb>; Wed, 15 Jan 2003 14:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbTAOTCa>; Wed, 15 Jan 2003 14:02:30 -0500
Received: from mail.zmailer.org ([62.240.94.4]:35031 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S266898AbTAOTCa>;
	Wed, 15 Jan 2003 14:02:30 -0500
Date: Wed, 15 Jan 2003 21:11:22 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem using integer division in kernel modules
Message-ID: <20030115191122.GV27709@mea-ext.zmailer.org>
References: <200301151941.29690.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301151941.29690.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 07:41:29PM +0100, Thomas Schlichter wrote:
> Hi,
> 
> I am writing at a small kernel module and have a problem now using / and %. If 
> I do so I get following unresolved symbols when the module should be loaded:
>   __divdi3
>   __moddi3

  64-bit division with non-constant non-power-of-two divider.

> Could you please help me and tell me what I do wrong..?

  The kernel is linked without gcc builtin libraries.
  Reasons can be found from FAQ (see footer), or archives.

/Matti Aarnio
