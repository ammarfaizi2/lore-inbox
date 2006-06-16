Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWFPKF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWFPKF1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 06:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWFPKF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 06:05:27 -0400
Received: from wx-out-0102.google.com ([66.249.82.202]:38331 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750967AbWFPKF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 06:05:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=c5WmBv9PKR+CePOXSD5ZsVhcdIrP+3nwmYoPPR08LsSFdiOZh0HykAc0XYqSCJf4oPArhpv3ssxm2P9xqfcBzdkpwEof7rCKuldHRf2Pt+tK/c1PRbXG2YKUJ6tjrdCCs1FhbEab8ZkXyrlG4W4N40i8/fK1mQNheb9hK1Igr0A=
Message-ID: <84144f020606160305ueae2050lc2d8f47944173971@mail.gmail.com>
Date: Fri, 16 Jun 2006 13:05:26 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Alessio Sangalli" <alesan@manoweb.com>
Subject: Re: APM problem after 2.6.13.5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44927F91.6050506@manoweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44927F91.6050506@manoweb.com>
X-Google-Sender-Auth: fc7f458580785354
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/16/06, Alessio Sangalli <alesan@manoweb.com> wrote:
> if I enable "APM support" I get a freeze at the very beginning of the
> boot, without any explicit erro message, just after the PCI stuff. If
> you need a transcript of the messages at boot, let me know, I will have
> to write them by hand).
> 2.6.13.5 is ok. I need APM support to let the "Fn" key and the battery
> meter work!

There's a lot of changes between 2.6.13 and 2.6.14.  It would be
helpful if you could narrow down the exact changeset that broke your
setup.  Please see the following URL for details:

  http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with-bisect.txt

                             Pekka
