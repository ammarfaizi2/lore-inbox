Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264329AbUFDAQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbUFDAQx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 20:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbUFDAQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 20:16:52 -0400
Received: from mail003.syd.optusnet.com.au ([211.29.132.144]:52455 "EHLO
	mail003.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264329AbUFDAQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 20:16:51 -0400
From: Con Kolivas <kernel@kolivas.org>
To: FabF <fabian.frederick@skynet.be>
Subject: Re: why swap at all?
Date: Fri, 4 Jun 2004 10:16:40 +1000
User-Agent: KMail/1.6.1
Cc: Valdis.Kletnieks@vt.edu, Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
References: <E1BVIVG-0003wL-00@calista.eckenfels.6bone.ka-ip.net> <1086279414.2295.13.camel@localhost.localdomain> <200406040956.17808.kernel@kolivas.org>
In-Reply-To: <200406040956.17808.kernel@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406041016.40927.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2004 09:56, Con Kolivas wrote:
> On Fri, 4 Jun 2004 02:16, FabF wrote:
> > On Thu, 2004-06-03 at 01:54, Con Kolivas wrote:
> > > Try this version instead which biases it downwards.
> >
> > I've been unhappy with this one.sw range : 19->60.
> > So I've been playing slightly with sw curve replacing nerve centre with
>
> Are you unhappy with the numbers for swappiness it gives or the feel of it?
> It gives a range of 0-100 in meaningful ways. Your version gives swappiness
> > 100 at times (oops). If this version does not feel good, the last linear
> one is better and you simply dont have enough ram for it to feel good after
> updatedb.

Oh and I forgot to say, if that's the case then you should try Nick's patches 
which are far more sophisticated than this.

Con
