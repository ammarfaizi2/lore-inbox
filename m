Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbVKJUVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVKJUVn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 15:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVKJUVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 15:21:43 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:62941 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751226AbVKJUVm (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 15:21:42 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: New Linux Development Model
Date: Thu, 10 Nov 2005 20:21:27 +0000
User-Agent: KMail/1.8.92
Cc: marado@isp.novis.pt, Linux-kernel@vger.kernel.org, fawadlateef@gmail.com,
       hostmaster@ed-soft.at, jerome.lacoste@gmail.com, carlsj@yahoo.com,
       Bill Davidsen <tmrbill@tmr.com>
References: <Pine.LNX.4.44.0511101500060.24169-100000@gaimboi.tmr.com>
In-Reply-To: <Pine.LNX.4.44.0511101500060.24169-100000@gaimboi.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511102021.27662.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 November 2005 20:08, Bill Davidsen wrote:
> On Thu, 10 Nov 2005, Alistair John Strachan wrote:
> > On Wednesday 09 November 2005 20:10, Marcos Marado wrote:
> > > On Wed, 2005-11-09 at 14:05 -0500, Bill Davidsen wrote:
> > > > With the current firmware and driver a "scan" shows 14 connectible
> > > > points outside an apartment building (only one secured in any way ;-)
> > > > whic is just what Windows shows. With the stock kernel zero are
> > > > found. That's not stable that's moribund.
> > >
> > > Sorry to disagree, but I use the stock kernel version of ipw2100 almost
> > > daily, with no problems.
> >
> > I concur, ipw2200 is also fully functional here. This sounds like a
> > genuine bug, or a mis-configured system, not a criticism of the current
> > Linux development model.
>
> Given that using recent firmware and drive software works and stock
> doesn't, I personally have a hard time saying that the configuration is
> wrong. Being old-fashioned I conclude that the thing you change to fix a
> problem is most likely the thing that caused the problem in the first
> place.
>
> can't speak to the 2100, I have a 2200, and with the current firmware and
> driver it works.

You need to use *exactly the right version* of the firmware (2.2 I believe) 
with the ipw2200 driver in 2.6.14. Non-2.2 firmwares just don't work with the 
1.0.0 driver (though the latest firmware obviously works with 1.0.8).

Are you using WPA{,2}? The driver in 2.6.14 doesn't do WPA, only WEP.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
