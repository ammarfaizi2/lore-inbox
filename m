Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWA0GCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWA0GCa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 01:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWA0GCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 01:02:30 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:36426 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932111AbWA0GC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 01:02:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=X1r1rGr/67QXiwdgLFVhH+RsruigDU0lmBxG5q73XplGNRo/MFjcOKRGf4AOzbXob5TwcfPuninTwR5UB604rKozYGNJtavNlv2/2lNb03nFpXQqDuhskBIpKcOhvK9WW925AyE2Tr0NDcn1YLY4yZK8CJYqzVpVMl2I4LFBl4w=
Message-ID: <43D9B77E.6080003@gmail.com>
Date: Fri, 27 Jan 2006 14:02:38 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Hai Zaar <haizaar@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: vesa fb is slow on 2.6.15.1
References: <cfb54190601260620l5848ba3ai9d7e06c41d98c362@mail.gmail.com>	 <43D8E1EE.3040302@gmail.com>	 <cfb54190601260806h7199d7aej79139140d145d592@mail.gmail.com>	 <43D94764.3040303@gmail.com> <cfb54190601261610o1479b8fdsbedb0ca96b14b6@mail.gmail.com>
In-Reply-To: <cfb54190601261610o1479b8fdsbedb0ca96b14b6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hai Zaar wrote:
>> You need both vga= and video=vesafb
> Thanks a lot - it did the trick - the speed is back!
> 
> But anyway, do you have a clue why do I still get this error?
> PCI: Failed to allocate mem resource #6:20000@f8000000 for 0000:40:00.0
> I've several workstations with _exactly_ the same hardware. I've tried
> two of them - both give the error with 2.6.15.1 (and no errors with
> 2.6.11.12).

Can you post the entire dmesg?

Tony
