Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268706AbUHYUy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268706AbUHYUy5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268674AbUHYUyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:54:51 -0400
Received: from verein.lst.de ([213.95.11.210]:26819 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268708AbUHYUvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:51:55 -0400
Date: Wed, 25 Aug 2004 22:51:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alex Zarochentsev <zam@namesys.com>
Cc: Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040825205149.GA17654@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Alex Zarochentsev <zam@namesys.com>,
	Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Lyamin aka FLX <flx@namesys.com>,
	Linus Torvalds <torvalds@osdl.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <20040825203516.GB4688@backtop.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825203516.GB4688@backtop.namesys.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 12:35:17AM +0400, Alex Zarochentsev wrote:
> Reiser4 may have a mount option for whoose who like or have to use traditional
> O_DIRECTORY semantics.  There would be no /metas under non-directories, if user
> wants that.

Again, O_DIRECTORY was added to solve a real-world race, not just for
the sake of it.  If you really want to add that option I'll research the
CAN number for you so you can named it after that - or just call it -o
insecure directly.

