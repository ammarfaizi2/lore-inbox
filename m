Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264968AbUEQL7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264968AbUEQL7z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 07:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264977AbUEQL7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 07:59:55 -0400
Received: from [144.51.25.10] ([144.51.25.10]:48543 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S264968AbUEQL7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 07:59:53 -0400
Subject: Re: [PATCH] scaled-back caps, take 4
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Chris Wright <chrisw@osdl.org>,
       Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Valdis.Kletnieks@vt.edu
In-Reply-To: <40A86789.6030006@myrealbox.com>
References: <fa.id6it11.41id3h@ifi.uio.no> <fa.gf5v6pu.c2mkrq@ifi.uio.no>
	 <40A86789.6030006@myrealbox.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1084795158.27531.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 17 May 2004 07:59:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-17 at 03:19, Andy Lutomirski wrote:
> So, if the core changes were merged, my caps semantics could be maintained 
> as a (fairly simple) separate LSM.  That prevents it working with SELinux 
> or other (non-stacking) LSMs loaded.

SELinux supports stacking with the existing capability module (SELinux
registers first, then the capability module registers as a secondary
module under it).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

