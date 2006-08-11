Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWHKBie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWHKBie (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 21:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWHKBie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 21:38:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:5690 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750824AbWHKBid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 21:38:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UrOWYIFztQ/gKO30UdhqD8qdXEzJhP13R0ltsbuzRYqMnkSR6kEAz75OvsKjD71DksnpHPh0vwDwk+rZGQsB9GbL7jAztSTzWmnqlLGVJFVkPYZ89HHZuNqIWLuEzdYV9UCE/nOSGwD/cqdrQFmaLirouWJJntGw3Kj+y0dAoP4=
Message-ID: <41840b750608101838jd19f514o2c13de1ca0fb16d0@mail.gmail.com>
Date: Fri, 11 Aug 2006 04:38:29 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: [PATCH 00/12] ThinkPad embedded controller and hdaps drivers (version 2)
Cc: "Jean Delvare" <khali@linux-fr.org>, "Greg KH" <gregkh@suse.de>,
       "Andrew Morton" <akpm@osdl.org>, "Robert Love" <rlove@rlove.org>,
       linux-kernel@vger.kernel.org, "Pavel Machek" <pavel@suse.cz>,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <9a8748490608101611x2e4eaa42qe987535031d27213@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1155203330179-git-send-email-multinymous@gmail.com>
	 <acdcfe7e0608100646s411f57ccse54db9fe3cfde3fb@mail.gmail.com>
	 <20060810131820.23f00680.akpm@osdl.org>
	 <20060810203736.GA15208@suse.de>
	 <20060810230545.84bbcb45.khali@linux-fr.org>
	 <9a8748490608101611x2e4eaa42qe987535031d27213@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/11/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:

> 1) Come out with his/her real name.

This won't happen anytime soon (I hope the people who will inevitably
reveal it will respect my wish to keep that private). But I'm working
with Linus, Andrew and a few other developers to find a workable
alternative, such as entrusting my full identity with them.


> 2) Provide detailed information about what sources of info these
> patches are based on.

I have done so.


> 3) Provide names and contact info for people at IBM/Lenovo/the company
> who made the gyroscope (can't remember who they are) etc etc, so that
> we can contact them and verify these patches are based on stuff that's
> OK.

This is ludicrous. I have no idea who these people are, nor any way to
reach them, nor any reason to do so (other than to ask them nicely to
release their specs properly next time and stop wasting everybody's
time). Since when do we have to ask vendor's permission to run Linux
on their hardware?!

BTW, the consensus on Google is that the accelerometer is a ADXL320 by
Analog Devices, whose specs are at [1], but the driver doesn't care or
know about this, since it's talking to the H8S embedded controller
which *drives* the accelerometer.

  Shem

[1] http://www.analog.com/en/prod/0,2877,ADXL320,00.html
