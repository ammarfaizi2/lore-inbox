Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271051AbTHCHFx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 03:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271055AbTHCHFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 03:05:53 -0400
Received: from lorien.emufarm.org ([66.93.131.57]:41426 "EHLO
	lorien.emufarm.org") by vger.kernel.org with ESMTP id S271051AbTHCHFw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 03:05:52 -0400
Date: Sun, 3 Aug 2003 00:05:42 -0700
From: Danek Duvall <duvall@emufarm.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test2-mm3
Message-ID: <20030803070542.GF10284@lorien.emufarm.org>
Mail-Followup-To: Danek Duvall <duvall@emufarm.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030802152202.7d5a6ad1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030802152202.7d5a6ad1.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 03:22:02PM -0700, Andrew Morton wrote:

> . I don't think anyone has reported on whether 2.6.0-test2-mm2 fixed any
>   PS/2 or synaptics problems.  You are all very bad.

I tried it on my Fujitsu P2120, hoping that the PS/2 resume patch would
help it wake up from S3 properly, but no such luck.  The radeon
framebuffer doesn't restore, and the keyboard doesn't work.  The mouse
might, but there's no way for me to tell.

If I remember correctly, the network functioned properly on resume in
test1-mm2, but doesn't in test2-mm3, so I had to do a reset.

Danek
