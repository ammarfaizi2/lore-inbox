Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270518AbTGXIVw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 04:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271148AbTGXIVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 04:21:52 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:59884 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S270518AbTGXIVv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 04:21:51 -0400
Message-ID: <3F1F9AD2.1060707@softhome.net>
Date: Thu, 24 Jul 2003 10:37:38 +0200
From: "Ihar \"Philips\" Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mfedyk@matchmail.com
Subject: Re: directory inclusion in ext2/ext3
References: <cypH.5dM.33@gated-at.bofh.it> <cCCR.hN.7@gated-at.bofh.it>
In-Reply-To: <cCCR.hN.7@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> On Wed, Jul 23, 2003 at 10:22:24PM +0200, softpro@gmx.net wrote:
> 
>>well, not really. unionfs is close because with a "mount -o bind" and 
>>additive mounting my problem would be solved, but what i'm looking for is a 
>>very high-level solution. as i said, my idea of solving this is to have an 
>>inclusion directive in directory-files...
>>
>>has nobody ever felt the lack of such functionality??
> 
> I guess not.
> 
> What exactly does this help you to do?
> 
> What do you want to accomplish?

   How can you make /home & /opt from one fs to appear together with 
/usr from another fs?

   Symlinks? A lot of distros & apps do not support this because of 
references like '../../../bin/echo'.
   And sometimes one may need to do references like this. Symlinks do 
not help... :-(((

