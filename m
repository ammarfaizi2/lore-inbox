Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133040AbRDRHEu>; Wed, 18 Apr 2001 03:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133042AbRDRHEl>; Wed, 18 Apr 2001 03:04:41 -0400
Received: from mail.axisinc.com ([193.13.178.2]:18184 "EHLO roma.axis.se")
	by vger.kernel.org with ESMTP id <S133040AbRDRHEa>;
	Wed, 18 Apr 2001 03:04:30 -0400
Message-ID: <E6FE4E054F02D511818E00025558B61D4B0A73@cluster01.axis.se>
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "'Eric S. Raymond'" <esr@snark.thyrsus.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
        axel@uni-paderborn.de, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: RE: Supplying missing entries for Configure.help, part 3
Date: Wed, 18 Apr 2001 09:03:12 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@snark.thyrsus.com> wrote:
> This patch supplies sixteen more missing entries for the
> Configure.help file, for a total of 48 so far.  It also corrects some
> places where periods are run onto URLs.  It should be applied after my
> previous patches 1 and 2 under the same title.  More to come...

Can we expect people adding entries in Configure.help to not write
URLs followed by a period in the future? I do not think so.

Would it not be better to teach your URL extractor (as I guess that
is the reason for this patch) what a URL followed by a period and a
space looks like. Even though they are legal URLs, I think we can
safely assume the writer intended the period to end the sentence and
not be part of the URL. The same goes for URLs followed by other
characters like comma, colon and so on.

//Peter
