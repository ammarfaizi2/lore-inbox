Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWDFLiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWDFLiz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 07:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWDFLiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 07:38:55 -0400
Received: from styx.suse.cz ([82.119.242.94]:62153 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751158AbWDFLiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 07:38:54 -0400
Date: Thu, 6 Apr 2006 13:38:49 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jim Gifford <maillist@jg555.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Header Sanitizing Project
Message-ID: <20060406113849.GA4714@suse.cz>
References: <4431DA7D.80907@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4431DA7D.80907@jg555.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2006 at 07:31:25PM -0700, Jim Gifford wrote:
> I've been working on a way to sanitize the headers. I've come up with a 
> process, that works for what I do, and hope to expand it with all the 
> positive feedback I've been getting. The product of this research is at 
> http://ftp.jg555.com/headers/headers2, and has a requirement of unifdef, 
> which is listed in the script itself.
> 
> When I was working on this project, I've noticed a lot of headers are 
> missing minor little things. Example. most if the if_*.h files are 
> missing asm/types.h. linux/input.h has a complete procedure that should 
> be under __KERNEL__. 

I can't find it in any recent git tree. Which one is it?

> Should I submit these as bugs along with the 
> patches? I have no problem submitting them.
> 
> Please advise me on the proper procedure on the findings, I can provide 
> more details, but everything is in my little script for sanitizing the 
> headers.
> 
> Thank you for all your help
> 
> Jim Gifford
> maillist@jg555.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-- 
Vojtech Pavlik
Director SuSE Labs
