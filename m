Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVC1X5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVC1X5x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 18:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVC1X5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 18:57:53 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:19648 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262129AbVC1X5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 18:57:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=HKTd+E5V9YD8weCuUH5t42yJkg66RUmWSL/yzZV+F1x5JMj2GMVDMtHpqav814pFeVbsEG7TPk3mKA0feADHvCOUtmBVzSyT9tHDKk4AJZoQ1UQji7SHLhXQPxHhocgGqh0vC+ITSk+XSjGPEwe/1nh6Zzp6qlC58ZdkiyntaYM=
Message-ID: <21d7e9970503281557366445ee@mail.gmail.com>
Date: Tue, 29 Mar 2005 09:57:49 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Phil Oester <kernel@linuxace.com>, David Woodhouse <dwmw2@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Garbage on serial console after serial driver loads
In-Reply-To: <20050328200243.C2222@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050328173652.GA31354@linuxace.com>
	 <20050328200243.C2222@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Seems like you are correct, given the below patch fixes the garbage
> > output for me.
> 
> David,
> 
> Is this patch ok for you?

Just an aside, I've had this patch in my own internal tree for over a
year I never thought it would be kernel acceptable... but I noticed
this problem a long time ago and thought it was an issue with my
internal hardware as I never saw it on a normal board...

Dave.
