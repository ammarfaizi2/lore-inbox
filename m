Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751835AbWJAFXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbWJAFXY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 01:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751743AbWJAFXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 01:23:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:33850 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751384AbWJAFXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 01:23:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=o+FwfcYyi4xdIv/WUxp4Po3rZwtIvYqXniWeKLRNh8LaHKQ8HSFfvZGSdlU+UhPMKBlxeFGht1qZe7Gc7/8DUnbJGk8WVmcV16rEulE9DZVLTH9g+1BNu3AP4Rih5X7gTPP42vACYw4b3pFNdFc1AZY38ZD4FKzdPZcZJ2wLQHY=
Message-ID: <84144f020609302223i1cb126dfgf3e006c891fdcc4e@mail.gmail.com>
Date: Sun, 1 Oct 2006 08:23:21 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: wireless abi breakage (was Re: 2.6.18-git9 wireless fixes break ipw2200 association to AP with WPA)
Cc: "Jean Tourrilhes" <jt@hpl.hp.com>,
       "Alessandro Suardi" <alessandro.suardi@gmail.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20060930193853.GA6890@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a4c581d0609291225r4a2cbaacr35e5ef73d69f8718@mail.gmail.com>
	 <20060929202928.GA14000@tuxdriver.com>
	 <5a4c581d0609291340q835571bg9657ac0a68bab20e@mail.gmail.com>
	 <20060929212748.GA10288@bougret.hpl.hp.com>
	 <20060930193853.GA6890@ucw.cz>
X-Google-Sender-Auth: 647604c1050fc9e6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/06, Pavel Machek <pavel@ucw.cz> wrote:
> Well... we are trying to have stable abi here. Breaking older wireless
> tools randomly is *not* okay in the middle of stable series.

Seconded. This is totally unacceptable so please fix up the ABI. You
must follow the proper procedure and add incompatible changes to
Documentation/feature-removal-schedule.txt so people will have enough
to migrate.
