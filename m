Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932664AbWKENDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbWKENDL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 08:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbWKENDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 08:03:11 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:27611 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932664AbWKENDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 08:03:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IucIMNz55GH23WbK1Icup2PfTP2ahrkxW1l7pxZsHWSzHFtfLBRH4F6CYb7c9qaP7EoOfiReEyOxhJ2Jp8vQlZNow4zEoslWAOnKuBDHbi03UaN4uV84lQsRk2118d5MLauViea+ekWNGLlmhAadUmfdXa4cYpUOym3v8wpcbMc=
Message-ID: <c87e555d0611050503q5d344ac9r8726d61115b024b3@mail.gmail.com>
Date: Sun, 5 Nov 2006 14:03:09 +0100
From: "Maurizio Lombardi" <m.lombardi85@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <Pine.LNX.4.64.0611041938490.24713@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
	 <454A76CC.6030003@cosmosbay.com>
	 <Pine.LNX.4.64.0611041938490.24713@artax.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/06, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> wrote:

>free space is organized in lists of free runs
>and converted to bitmap only in case of
>extreme fragmentation.

There is a performance reason to prefer lists of free blocks rather than bitmap?

I read from [Tanenbaum: Operating System, Design and Implementation II
ed. ] that lists are better than bitmap only when disk is almost full.


-- 
--------------------
Maurizio Lombardi
