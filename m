Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265777AbUBGUpj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 15:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUBGUpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 15:45:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49077 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265777AbUBGUpd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 15:45:33 -0500
Date: Sat, 7 Feb 2004 20:45:32 +0000
From: Matthew Wilcox <willy@debian.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: matthew@wil.cx, linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] sym53c8xx_2 uses SYM_MEM_CLUSTER_SHIFT before its #define'd
Message-ID: <20040207204532.GA24334@parcelfarce.linux.theplanet.co.uk>
References: <20040207203058.GA7388@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040207203058.GA7388@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 09:30:58PM +0100, Adrian Bunk wrote:
> This seems to be a bug:
> SYM_MEM_CLUSTER_SIZE is used before it's #define'd.
> 
> The patch below fixes this issue.

Thanks, I've taken this patch too.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
