Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264728AbUFPUUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264728AbUFPUUZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 16:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264731AbUFPUUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 16:20:25 -0400
Received: from [213.146.154.40] ([213.146.154.40]:11935 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264728AbUFPUUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 16:20:24 -0400
Date: Wed, 16 Jun 2004 21:20:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dirk Jagdmann <doj@cubic.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE Auto-Geometry Resizing support missing in 2.6.7?
Message-ID: <20040616202023.GA19123@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dirk Jagdmann <doj@cubic.org>, linux-kernel@vger.kernel.org
References: <40D0AA07.7010806@cubic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D0AA07.7010806@cubic.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 10:13:59PM +0200, Dirk Jagdmann wrote:
> Hello Kernel Developers,
> 
> I have just updated from 2.6.6 to 2.6.7. I need to use the IDE 
> Auto-Geometry Resizing support on my system (CONFIG_IDEDISK_STROKE). The 
> corresponding configuration option however was removed in 2.6.7 along 
> with the define in the .config file. Thus when booting my hard disks are 
> not properly detected (only with the clipped capacity).
> 
> Was the removal of this option intentional? Was the option renamed or moved?

You need to boot with hdX=stroke now.  I had a patch first that allowed both
run- an compiletime selection but Bart wanted the option to be removed.

