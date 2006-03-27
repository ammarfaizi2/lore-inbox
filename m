Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWC0QF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWC0QF2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 11:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbWC0QF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 11:05:28 -0500
Received: from wproxy.gmail.com ([64.233.184.226]:61934 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750909AbWC0QF1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 11:05:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fR5GH18/hs3rnuU3Zr7xinXnBpmWSDmV46SqrjUY/fwhERXQVax9eyzYH2hGcB6FRrCdqgc3NdzMVtu1uQSAVbqVHorFgwlIMEXnJlT+gCzB7vhD0uIVRRb/yhDtytxPxfIdj5rGLkVXyM51rXnBOP0p6irqpzOiijyMFt4TZr0=
Message-ID: <d120d5000603270805u40916079ufe12eb22d478c954@mail.gmail.com>
Date: Mon, 27 Mar 2006 11:05:26 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Romano Giannetti" <romanol@upcomillas.es>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: ALPS stop worked between 2.6.13 and 2.6.16
In-Reply-To: <20060327153624.GC8679@pern.dea.icai.upcomillas.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060327153624.GC8679@pern.dea.icai.upcomillas.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/06, Romano Giannetti <romanol@upcomillas.es> wrote:
>
> Hi all. I upgraded kernel from 2.6.13-rc3 to 2.6.16 and ALPS touchpad
> stopped worked. I have latest release of synaptics drivers, and can confirm
> that  exactly the same config results in a working ALPS on old kernel and no
> ALPS on newer (same config).
> Details here:
>
> http://www.dea.icai.upco.es/romano/linux/vaio-conf/config-2.6.16-ck1-after-boot/laptop-config.html
>
> and
>
> http://www.dea.icai.upco.es/romano/linux/vaio-conf/config-2.6.13-rc3-rg-after-a-bit/
>

Hi,

According to your dmesg your ALPS touchpas awas successfully detected
by the kernel. Please make sure that you have updated udev package.

--
Dmitry
