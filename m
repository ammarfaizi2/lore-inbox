Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262811AbVA1W4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbVA1W4T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 17:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbVA1W4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 17:56:19 -0500
Received: from mailhub1.une.edu.au ([129.180.1.122]:10666 "EHLO
	mailhub1.une.edu.au") by vger.kernel.org with ESMTP id S262811AbVA1W4L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 17:56:11 -0500
Date: Sat, 29 Jan 2005 09:56:09 +1100
From: Norman Gaywood <norm@turing.une.edu.au>
To: Mark Rustad <mrustad@mac.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: panic in raid1_end_write_request
Message-ID: <20050128225609.GA15731@turing.une.edu.au>
References: <20050128212334.GA6576@turing.une.edu.au> <B5832974-717C-11D9-B1C1-0003934F6348@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B5832974-717C-11D9-B1C1-0003934F6348@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mark,

On Fri, Jan 28, 2005 at 04:34:01PM -0600, Mark Rustad wrote:
> I used to get these running SuSE SLES 9 and also with a variety of 
> kernel.org kernels. The crash was triggered by a media error on a 
> RAID1.

Were there any media errors logged? My system does not log any such errors.

>        A patch that I got from SuSE fixed it for me. The patch is below 
> your message excerpt.

That looks like the "bio clone memory corruption" patch which is
supposed to be in 2.6.10-1.747_FC3smp via 2.6.10-ac10 being included in
that kernel.

I was hoping that would solve my problem as well, but it didn't.

-- 
Norman Gaywood, Systems Administrator
School of Mathematics, Statistics and Computer Science
University of New England, Armidale, NSW 2351, Australia

norm@turing.une.edu.au            Phone: +61 (0)2 6773 2412
http://turing.une.edu.au/~norm    Fax:   +61 (0)2 6773 3312

Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
