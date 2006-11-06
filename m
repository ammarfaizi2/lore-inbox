Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753482AbWKFRJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbWKFRJP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 12:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbWKFRJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 12:09:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:21288 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1753482AbWKFRJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 12:09:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=EYZB07a7EtJOGCgb0qIiaz7AAnrrzDDKcPBvGbZzBAje9QAUJ1LxmAj88pyA6ngu2RAi8x1vWP/zijx23l+wO3uh04j67j5dwl4DpoYM/5yqUglME8BT50h0RCRaFopEV51QjZHM/TuTEize4NN0AhlTxeqPQp3IuCBW6LeEE7c=
Message-ID: <161717d50611060909m7f034a45weaf6552b1a7550e9@mail.gmail.com>
Date: Mon, 6 Nov 2006 12:09:10 -0500
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [RFT/PATCH] i8042: remove polling timer (v6)
Cc: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Vojtech Pavlik" <vojtech@suse.cz>
In-Reply-To: <d120d5000611060848k1f5fa2f7r7e78a0eca88a59ce@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608232311.07599.dtor@insightbb.com>
	 <161717d50610291520i5076901blf8bf253eba6148cc@mail.gmail.com>
	 <200611030103.17913.dtor@insightbb.com>
	 <161717d50611060822w11e031ebra8f62d0fc5b02d69@mail.gmail.com>
	 <d120d5000611060848k1f5fa2f7r7e78a0eca88a59ce@mail.gmail.com>
X-Google-Sender-Auth: 44f417aa0d7ce35f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> It would be interesting to see dmesg of reloading psmouse module after
> touchpad freezes:
>
> echo 1 > /sys/module/i8042/parameters/debug
> rmmod psmouse
> modprobe psmouse

Sure, will try it.

>
> BTW, what video driver are you using?

Free x.org Radeon driver (r200?).

Dave
