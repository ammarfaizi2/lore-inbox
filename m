Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbUCJQqX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 11:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbUCJQqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 11:46:23 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:1807 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262708AbUCJQqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 11:46:22 -0500
Date: Wed, 10 Mar 2004 16:46:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Thomas Horsten <thomas@horsten.com>, andre@linux-ide.org,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.x Linux Medley RAID Version 7
Message-ID: <20040310164617.A24567@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Thomas Horsten <thomas@horsten.com>, andre@linux-ide.org,
	arjanv@redhat.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.40.0403101515410.1120-100000@jehova.dsm.dk> <200403101707.38595.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200403101707.38595.bzolnier@elka.pw.edu.pl>; from B.Zolnierkiewicz@elka.pw.edu.pl on Wed, Mar 10, 2004 at 05:07:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 05:07:38PM +0100, Bartlomiej Zolnierkiewicz wrote:
> +	if (!inode || !inode->i_rdev)
> +	{
> +		return -EINVAL;
> +	}
> 
> if (!inode || !inode->i_rdev)
> 	return -EINVAL;

Actually it should just go away.  The check is totally bogus.

