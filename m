Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVKLFAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVKLFAs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 00:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVKLFAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 00:00:48 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:26814 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932073AbVKLFAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 00:00:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=aRKN5GszfHZwVp7+FhxG+cJ1meDNVivJtBQzhtat+0zZugQ8cFIcySWxI8jFgNHicFGb4m1SYZxqt5ziYc0dc1oY6e4J4dy9I26cis/u7mozILANCMGk7VJQ23K8m0PbY93V4QYAi8Sjzw1rMyWepBONX1SxuP34TTOsdC7OBFQ=
Message-ID: <437576F3.7050309@pol.net>
Date: Sat, 12 Nov 2005 13:00:35 +0800
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: drivers/video/nvidia/ compile error with PPC_OF=y, FB_OF=n
References: <20051112041649.GU5376@stusta.de>
In-Reply-To: <20051112041649.GU5376@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: "Antonino A. Daplas" <adaplas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> I got the following compile error in 2.6.14-mm2 that seems to come from 
> Linus' tree:
> 
> <--  snip  -->
> 
> ...
>   CC [M]  drivers/video/nvidia/nv_of.o
> drivers/video/nvidia/nv_of.c:33: error: redefinition of 'nvidia_probe_of_connector'
> drivers/video/nvidia/nv_proto.h:51: error: previous definition of 'nvidia_probe_of_connector' was here
> make[3]: *** [drivers/video/nvidia/nv_of.o] Error 1
> 

Yes, akpm already made a fix for this.

Tony
