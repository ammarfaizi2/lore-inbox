Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268781AbUHZLiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268781AbUHZLiX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268765AbUHZLfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:35:52 -0400
Received: from levante.wiggy.net ([195.85.225.139]:12191 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S268742AbUHZL1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:27:17 -0400
Date: Thu, 26 Aug 2004 13:27:16 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Spam <spam@tnonline.net>
Cc: Andrew Morton <akpm@osdl.org>, jra@samba.org, torvalds@osdl.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826112716.GJ2612@wiggy.net>
Mail-Followup-To: Spam <spam@tnonline.net>, Andrew Morton <akpm@osdl.org>,
	jra@samba.org, torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flx@namesys.com, reiserfs-list@namesys.com
References: <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1939276887.20040826114028@tnonline.net> <20040826024956.08b66b46.akpm@osdl.org> <839984491.20040826122025@tnonline.net> <20040826032457.21377e94.akpm@osdl.org> <742303812.20040826125114@tnonline.net> <20040826035500.00b5df56.akpm@osdl.org> <1453776111.20040826131547@tnonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453776111.20040826131547@tnonline.net>
User-Agent: Mutt/1.5.6+20040523i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Spam wrote:
>   Also,  you  are thinking _very_ narrowly now. There are thousands of
>   file  formats.  Implementing  the  support  for  meta-data/ streams/
>   attributes  in  the  kernel  will  make  it  possible  to  use  this
>   generically for all files.

And how many different formats will be used for thumbnails? How many
different names to indicate a summary for a document?

Having the ability to add attributes standardizes a way to access that
data, but not the format and naming of those attributes. It could be
a step closer to a more flexible way of handling storage, but you have
to realize that a lot (if not most) of the work still needs to be done
in userspace.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
