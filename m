Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129944AbRARQS4>; Thu, 18 Jan 2001 11:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130017AbRARQSh>; Thu, 18 Jan 2001 11:18:37 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:1805 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129944AbRARQSa>; Thu, 18 Jan 2001 11:18:30 -0500
Date: Thu, 18 Jan 2001 17:18:27 +0100
From: Jan Kara <jack@suse.cz>
To: M T <hyponephele@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: quota and 2.4.0-ac9
Message-ID: <20010118171827.A31138@atrey.karlin.mff.cuni.cz>
In-Reply-To: <F1300rmTIVvLVKi3s1w00005b3c@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <F1300rmTIVvLVKi3s1w00005b3c@hotmail.com>; from hyponephele@hotmail.com on Tue, Jan 16, 2001 at 07:15:50AM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When running 'quotaon -a' I get message 'quotaon: using /quota.user on 
> /dev/hdc3: Invalid argument'. This occurs at least with 2.4.0-ac4 and 
> 2.4.0-ac9, but not with 2.4.0.
  That's because 2.4.0-ac? supports new quota format which is incompatible
with the old one... You need also new utilities to manipulate with format
(I'm actually working with Marco to create utils which would support
both formats). You can download these utils at:
ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/utils/quota-3.00-4.tar.gz

Then read manpage of convertquota if you're interested.

							Honza
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
