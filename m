Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbTEKOUt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 10:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTEKOUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 10:20:49 -0400
Received: from ulima.unil.ch ([130.223.144.143]:28593 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id S261444AbTEKOUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 10:20:48 -0400
Date: Sun, 11 May 2003 16:33:30 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lilo and 2.5.69?
Message-ID: <20030511143330.GA11792@ulima.unil.ch>
References: <fa.esb041l.fng3gd@ifi.uio.no> <fa.fb22044.i12sp4@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa.fb22044.i12sp4@ifi.uio.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fa.linux.kernel, you wrote:

> You need to fix lilo to not assume the names listet in /proc/partitions are
> actual device files.  In 2.5.69 there's a bug that it prints truncated devfs
> names instead of traditional device names as it should, but relying on the
> names to mean anything is broken - that kernel can't enforce the device names
> used.
> 
> The following patch that is in Linus BK tree should get it working for you
> again for now..

Great ;-)

I'll compil with your patch: thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
