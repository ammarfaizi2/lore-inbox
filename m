Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129983AbQKUUST>; Tue, 21 Nov 2000 15:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131197AbQKUUSJ>; Tue, 21 Nov 2000 15:18:09 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11789 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129983AbQKUUSB>; Tue, 21 Nov 2000 15:18:01 -0500
Date: Tue, 21 Nov 2000 20:48:07 +0100
From: Jan Kara <jack@suse.cz>
To: "Ron L. Smith" <hunter@thuntek.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Quota files on root FS get "too large" error after 2.4.x upgrade
Message-ID: <20001121204807.A5434@atrey.karlin.mff.cuni.cz>
In-Reply-To: <002f01c053ca$cc6a6d80$0200a8c0@ruby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <002f01c053ca$cc6a6d80$0200a8c0@ruby>; from hunter@thuntek.net on Tue, Nov 21, 2000 at 07:53:23AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.

> After installing and configuring kernel 2.4.0-test11, all is working well,
> except quota's on the root FS.  I am at a loss as to how to correct this:
> 
> ls -l /quota.*
> ls: /quota.group: Value too large for defined data type
> ls: /quota.user: Value too large for defined data type
> 
> rm -f /quota.*
> rm: cannot remove `/quota.group': Value too large for defined data type
> rm: cannot remove `/quota.user': Value too large for defined data type
> 
> I have just started testing with the 2.4.x series kernel, so do not know if
> this would have been seen in any previous testxx version.
  Strange... Could you send strace of ls, so that I can get idea where this
message comes from?

					Thanks
						Honza

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
