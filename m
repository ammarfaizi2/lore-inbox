Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbVIRG4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbVIRG4G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 02:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVIRG4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 02:56:06 -0400
Received: from dial169-188.awalnet.net ([213.184.169.188]:55044 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S1751193AbVIRG4E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 02:56:04 -0400
From: Al Boldi <a1426z@gawab.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: Eradic disk access during reads
Date: Sun, 18 Sep 2005 09:54:32 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200509170717.03439.a1426z@gawab.com> <200509180716.46978.a1426z@gawab.com> <20050918052301.GA20422@alpha.home.local>
In-Reply-To: <20050918052301.GA20422@alpha.home.local>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200509180951.50259.a1426z@gawab.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Sun, Sep 18, 2005 at 07:16:46AM +0300, Al Boldi wrote:
> >
> > New synonym: eradic=erratic :)
> >
> > The problem seems to be a multi-access collision in the queue, which
> > forces a ~50% reduction of thruput, which recovers with another
> > multi-access collision.  Maybe?!
>
> do you have anything else connected to the same controller ? 

Nothing, but hda.

This problem only shows in 2.6.13, 2.4.31 works ok!

Maybe this is also accociated to the block-dev read-ahead problem?

Thanks!

--
Al


