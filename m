Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265529AbUABMpi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 07:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265530AbUABMph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 07:45:37 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:20178 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265529AbUABMp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 07:45:26 -0500
Subject: Re: CPRM ?? Re: Possibly wrong BIO usage in ide_multwrite
From: Christophe Saout <christophe@saout.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10401012018030.32122-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10401012018030.32122-100000@master.linux-ide.org>
Content-Type: text/plain
Message-Id: <1073047522.4239.6.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 02 Jan 2004 13:45:22 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr, den 02.01.2004 schrieb Andre Hedrick um 05:43:

> I am sorry but adding in a splitter to CPRM is not acceptable.
> Digital Rights Management in the kernel is not acceptable to me, period.
> 
> Maybe I have misread your intent and the contents on your website.
>
> Device-Mappers are one thing, intercepting buffers in the taskfile FSM
> transport is another.  This stinks of CPRM at this level, regardless of
> your intent.  Do correct me if I am wrong.

I can assure you I was never having DRM or anything like this in mind
nor making fundamental changes to the IDE layer. It was just that
++bi_idx that bugged me. Must be a misunderstanding, sorry. :)

The only thing I'm having on my website is a device-mapper target that
does basically the same as cryptoloop tries to. It's just about
encrypting sensitive data on top of any other device, nothing else.


