Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVDXHab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVDXHab (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 03:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVDXHab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 03:30:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3310 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262281AbVDXHa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 03:30:28 -0400
Date: Sun, 24 Apr 2005 08:30:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Borislav Petkov <petkov@uni-muenster.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050424073027.GA13972@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Borislav Petkov <petkov@uni-muenster.de>,
	linux-kernel@vger.kernel.org
References: <200504220956.43883.petkov@uni-muenster.de> <20050424054231.GA25561@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050424054231.GA25561@kroah.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2005 at 10:42:31PM -0700, Greg KH wrote:
> What is your .config that generates this?  What arch?

should happen on all architectures with usb-storage debugging enabled.

Someone fucked up usb-stroage again after I cleaned up usage of the
old-style scsi.h header, and this is the result of scsi.h gradually
going away.

The patch posted isthe correct fix.
