Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWIYRFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWIYRFG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 13:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWIYRFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 13:05:06 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:55495 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751264AbWIYRFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 13:05:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Nc2/13TIxkxVevshUXKa44RDkA9KUaFYB6bf58eXZIKEv2j9DfmSuPsZI09p/7WsfBZotgH2qnVloH807+zbQRLqkzMnFjQ8mDccHq7WL53nktS/48v6GaRfqRTpq5/n9TPKJuvXpLeCj1npoZiz15ds+9i0IBQEi3kdEJG/Noc=
Message-ID: <2c0942db0609251004h288818c9k4f1c8684b956b72@mail.gmail.com>
Date: Mon, 25 Sep 2006 10:04:57 -0700
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "john stultz" <johnstul@us.ibm.com>
Subject: Re: 2.6.19 -mm merge plans (NTP changes)
Cc: "Roman Zippel" <zippel@linux-m68k.org>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1159203005.8288.16.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060920135438.d7dd362b.akpm@osdl.org>
	 <1158805731.8648.54.camel@localhost>
	 <Pine.LNX.4.64.0609211217190.6761@scrub.home>
	 <1159203005.8288.16.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/06, john stultz <johnstul@us.ibm.com> wrote:
> I was able to run tests for two days each w/ and w/o the patch I had
> concerns about. And indeed, it seems if the drift file is reset, the
> initial convergence is much slower (and this is really what worried me).
> However once it converges it seems to keep sync as well as the current
> code.

So slower convergence isn't a regression?

Ray
