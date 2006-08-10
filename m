Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161460AbWHJQsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161460AbWHJQsv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161456AbWHJQss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:48:48 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:43151 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1161455AbWHJQsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:48:47 -0400
Date: Thu, 10 Aug 2006 18:48:32 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] Forking ext4 filesystem from ext3 filesystem
Message-ID: <20060810164832.GA305@wohnheim.fh-wedel.de>
References: <1155172622.3161.73.camel@localhost.localdomain> <20060809233914.35ab8792.akpm@osdl.org> <44DB61D7.1000109@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44DB61D7.1000109@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 August 2006 09:41:59 -0700, Mingming Cao wrote:
> 
> I agree with you that the timing is right, to do the clean up now rather 
> than later. I would give it a try. If I could get more help from more 
> code reviewer, it probably makes the effort a lot easier. For those 
> issues you pointed out : coding style problem??incorrect comments, 
> poorly-named variables  -- do you have any specific examples in your mind?

For whitespace damage, you can try the following regex:
/\s\+$\| \+\ze\t/

Or if you use vim as an editor, you can add this to your vimrc:
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/

For example, it will show 4 cases of trailing whitespace in the quoted
part of your email above. :)

Jörn

-- 
You ain't got no problem, Jules. I'm on the motherfucker. Go back in
there, chill them niggers out and wait for the Wolf, who should be
coming directly.
-- Marsellus Wallace
