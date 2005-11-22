Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbVKVV2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbVKVV2o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbVKVV2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:28:44 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:16798 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964906AbVKVV2n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:28:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b946ftUq8pq2uxGdH8JyrZrwTtZeVCXjmNTuoS7bETpgDNs7Q0weor4Ry4lfGN+IXXeJhyLk1L848hw6w5Dffg7BEOCUKT70hPd9tmkj4ZZvq8WS2yt2bg6jvii42QrHhT4tUF/JAvElCK9xgrv+LJPmdTkhOTMSZ6y16esjUdM=
Message-ID: <d120d5000511221328l15925cd4o5429a92bec29c494@mail.gmail.com>
Date: Tue, 22 Nov 2005 16:28:42 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: Christmas list for the kernel
Cc: Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051122204918.GA5299@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <20051122204918.GA5299@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/05, Greg KH <greg@kroah.com> wrote:
> On Tue, Nov 22, 2005 at 01:31:16PM -0500, Jon Smirl wrote:
> >
> > 4) Merge klibc and fix up the driver system so that everything is
> > hotplugable. This means no more need to configure drivers in the
> > kernel, the right drivers will just load automatically.
>
> What driver subsystem is not hotplugable and does not have automatically
> loaded modules today?
>

Input core does not have modalias and needs a special handler to load
interfaces (mousedev, joydev, tsedv, evdev). But input_id is _huge_
and I am not sure that using modalias is a good idea here.

--
Dmitry
