Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUHFJOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUHFJOQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 05:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268050AbUHFJOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 05:14:16 -0400
Received: from [213.146.154.40] ([213.146.154.40]:62108 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266680AbUHFJOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 05:14:14 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: David Woodhouse <dwmw2@infradead.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: axboe@suse.de, kernel@wildsau.enemy.org, linux-kernel@vger.kernel.org
In-Reply-To: <200408060833.i768X6Z6005223@burner.fokus.fraunhofer.de>
References: <200408060833.i768X6Z6005223@burner.fokus.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1091783648.4383.4742.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 06 Aug 2004 10:14:08 +0100
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-06 at 10:33 +0200, Joerg Schilling wrote:
> It creates bad impressions if people from LKML are a source of unrelated rants.

That line is more than 78 characters long, in violation of another
'RECOMMENDED' in §3.5 of RFC2822. You didn't present any justification
for violating §3.6.4 -- do you have any justification for this one?

> Please stop this if you don't like to conribute to the subject.

It's not an unrelated rant. If you want to participate in a public
forum, you are expected to show a little bit of respect for netiquette.

I don't have anything to contribute to the thread -- it's not my area of
expertise. Hence I want to ignore the thread -- but that's not easy
since your broken MUA keeps creating _new_ threads.

> BTW: I am using 'mailx' which is _the_ official mail reader from the POSIX 
> standard......

I care not what it is; it's broken. Please stop using it in public fora.

I note that it also includes 8-bit data without Content-Type: or
Content-Transfer-Encoding: headers. According to §§5.2 and 6.1 of
RFC2045, the default values to be assumed in the absence of those
headers are 'text/plain; charset=us-ascii' and '7BIT' respectively. It
is therefore erroneous to use the octet 0xf6 where presumably you
intended the character 'ö', because that is not a valid US-ASCII
character, and because the octet 0xf6 is not permitted in '7bit' data.

-- 
dwmw2

