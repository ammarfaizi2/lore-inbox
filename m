Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269112AbRHFWle>; Mon, 6 Aug 2001 18:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269101AbRHFWlZ>; Mon, 6 Aug 2001 18:41:25 -0400
Received: from mail.zmailer.org ([194.252.70.162]:48402 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S269082AbRHFWlE>;
	Mon, 6 Aug 2001 18:41:04 -0400
Date: Tue, 7 Aug 2001 01:41:01 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Stephen M. Williams" <rootusr@midsouth.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is the mailing list going out?
Message-ID: <20010807014101.U11046@mea-ext.zmailer.org>
In-Reply-To: <997135113.558.1.camel@bofumgw.bofum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <997135113.558.1.camel@bofumgw.bofum.net>; from rootusr@midsouth.rr.com on Mon, Aug 06, 2001 at 04:58:27PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 04:58:27PM -0500, Stephen M. Williams wrote:
> My apologies for the off-topic question, but I've not received any mail
> from the list in about 4 days and was wondering if there's a known issue
> with this or if I need to harrass my ISP regarding the mail servers.
> Please cc me as I am subscribed, but not receiving ;)

   No, you are not subscribed - anymore.
We (postmasters of vger) got a lot of 'relaying denied' for your
domain, and the subscription got revoked.

Verify your email routing with tool:
   http://vger.kernel.org/mxverify.html

... looks like that is ISP system, and now it works.

The diagnostic data told me:

  Original-Recipient: rfc822;rootusr@midsouth.rr.com
  Final-Recipient: RFC822;rootusr@midsouth.rr.com
  Action: failed
  Status: 5.7.1
  Diagnostic-Code: smtp; 550 (<rootusr@midsouth.rr.com>... Relaying denied)
  Remote-MTA: dns; vamx01.mgw.rr.com (24.30.201.18|25|199.183.24.194|51071)
  Last-Attempt-Date: Thu, 2 Aug 2001 05:39:22 -0400

The mxverify reported data shows signature characteristics of
sendmail system used by your ISP - even though they try to hide
the system software version, I don't know of any system aside
of  sendmail  to report "ONEX" facility for EHLO response.

Perhaps their sendmail didn't get access to some dataset, and
it (in "good" sendmail style) didn't bother reporting that it
has problem to access data and ask to come back latter, instead
it reports permanent failure rejecting email.
(That is bloody common thing with sendmail...)


> Thanks :)
> -- 
> Stephen Williams
> mailto:rootusr@midsouth.rr.com

/Matti Aarnio
