Return-Path: <linux-kernel-owner+w=401wt.eu-S932117AbXAIOvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbXAIOvH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 09:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbXAIOvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 09:51:06 -0500
Received: from wr-out-0506.google.com ([64.233.184.229]:24460 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbXAIOvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 09:51:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dwc4iekP/sg9+BKbL1UsHsJn16oC8Om2YM78sviuTd/olONppaXnXkKKx4+uaTjDKqg+C35Q0bqyvDUDE+mOETUXlfcaGCgVP8BXfee3cyu3VeicMlvI+sRBRnqZ1vC39L8+7fx9s2QOPrpP8DmbDv1DcTZQXn/R9SigG3+A6aU=
Message-ID: <3877989d0701090651m84d7f41v5d06e1638a7eb31d@mail.gmail.com>
Date: Tue, 9 Jan 2007 22:51:04 +0800
From: "Luming Yu" <luming.yu@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>, "Lee Revell" <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc3 regression: suspend to RAM broken on Mac mini Core Duo
In-Reply-To: <20070108210428.GA7199@dose.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070107151744.GA9799@dose.home.local>
	 <1168194194.18788.63.camel@mindpipe>
	 <20070107200453.GA3227@thinkpad.home.local>
	 <20070107222706.GA6092@thinkpad.home.local>
	 <20070107234445.GM20714@stusta.de>
	 <20070108210428.GA7199@dose.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > It didn't. It looks like it is unusable, becuase it isn't reliable in
> > > 2.6.20-rc3.
> >
> > Is this issue still present in -rc4?
>
> I used 2.6.20-rc4 in single user mode, and applied 2 patches from
> netdev to get wake on LAN support. This way I was able to set up an
> automatic suspend/resume loop. It looked good, but after e.g. 20
> minutes, the resume hang. So it is reproduceable with 2.6.20-rc4.
> Unfortunately, I can not test the same with 2.6.18, as the wake on LAN
> patches need 2.6.20-rc.

Hmm, do you mean this is the first time of this kind of testing?
Is this issue related to LAN driver?
I guess you should be able to set up an automatic suspend/resume loop
with /proc/acpi/alarm, and test similar with 2.6.18.

--Luming
