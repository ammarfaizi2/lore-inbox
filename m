Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWA0AK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWA0AK3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWA0AK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:10:29 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:30548 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751296AbWA0AK3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:10:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WPN12MsGKHzEIoFtCOxdVqS0rgwYgT56WG+fifBqhj4JB3BKQuaXtS40lXK+wUMVMXXAWuZa5A3QDxmlv+2TQu3n6CjlIAOb6DKijR6civvOJLSy2ZQLAxYuhqw2IScT0SN80LAT63akriBEzze36UpBkb9FuBLxYMeQFSejsoE=
Message-ID: <cfb54190601261610o1479b8fdsbedb0ca96b14b6@mail.gmail.com>
Date: Fri, 27 Jan 2006 02:10:28 +0200
From: Hai Zaar <haizaar@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: vesa fb is slow on 2.6.15.1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43D94764.3040303@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cfb54190601260620l5848ba3ai9d7e06c41d98c362@mail.gmail.com>
	 <43D8E1EE.3040302@gmail.com>
	 <cfb54190601260806h7199d7aej79139140d145d592@mail.gmail.com>
	 <43D94764.3040303@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> You need both vga= and video=vesafb
Thanks a lot - it did the trick - the speed is back!

But anyway, do you have a clue why do I still get this error?
PCI: Failed to allocate mem resource #6:20000@f8000000 for 0000:40:00.0
I've several workstations with _exactly_ the same hardware. I've tried
two of them - both give the error with 2.6.15.1 (and no errors with
2.6.11.12).
>
> Tony
>


--
Zaar
