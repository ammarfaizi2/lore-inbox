Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbTJZL42 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 06:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbTJZL42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 06:56:28 -0500
Received: from gprs195-16.eurotel.cz ([160.218.195.16]:40834 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263106AbTJZL41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 06:56:27 -0500
Date: Sun, 26 Oct 2003 12:56:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: John Bradford <john@grabjohn.com>, "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Hans Reiser '" <reiser@namesys.com>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       linux-kernel@vger.kernel.org, nikita@namesys.com,
       "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results get worse
Message-ID: <20031026115613.GA4312@elf.ucw.cz>
References: <334101c39b94$268a0370$24ee4ca5@DIAMONDLX60> <200310261039.h9QAdniV000310@81-2-122-30.bradfords.org.uk> <358a01c39bb5$c651c7a0$24ee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <358a01c39bb5$c651c7a0$24ee4ca5@DIAMONDLX60>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> By the way some participants in this thread have argued that the block
> should not be replaced by zeroes or random garbage without notice.  I fully
> agree.  The block should be replaced by zeroes or random garbage WITH
> notice.  From the point of view of logging it in the system log, it is
> enough to log it once, it doesn't have to be logged over and over
> again.

It *does* have to be logged over and over. How does disk know system
did not crash between it returning an error and syslog message getting
written?

								Pavel
PS: Okay, we should end this thread here.
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
