Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbTJORoa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 13:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263812AbTJORoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 13:44:30 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:60649 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S263810AbTJORo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 13:44:26 -0400
From: David Woodhouse <dwmw2@infradead.org>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: josh@temp123.org, linux-kernel@vger.kernel.org
In-Reply-To: <20031015105655.C1593@schatzie.adilger.int>
References: <1066163449.4286.4.camel@Borogove>
	 <1066235105.14783.1602.camel@hades.cambridge.redhat.com>
	 <20031015105655.C1593@schatzie.adilger.int>
Message-Id: <1066239856.18189.13.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-3.dwmw2.1) 
Date: Wed, 15 Oct 2003 18:44:16 +0100
X-SA-Exim-Mail-From: dwmw2@infradead.org
Subject: Re: Transparent compression in the FS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-15 at 10:56 -0600, Andreas Dilger wrote:
> Actually, reiserfs also supports ext2-compatible SETFLAGS/GETFLAGS ioctls.
> This allows us to use the same tools for lsattr and chattr instead of using
> lsattr.reiserfs, etc.  Our Lustre distributed filesystem does the same.

Yeah - I probably will too if I ever get round to letting people
actually disable the compression :)

-- 
dwmw2


