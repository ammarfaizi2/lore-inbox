Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030501AbVIOPdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbVIOPdo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 11:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030500AbVIOPdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 11:33:44 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:63056 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030493AbVIOPdn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 11:33:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nx/J2cV2NqN15T5+ddJ7KzDvJ2ZQS8S4oNQPutOabLO/59rLZKEKMyNXOm1rlI0f3VwOBRsLszaCxTZRc8txnhjBkU+2Skk7krfmQExN1uwvKHOzIuLXmsSwGdDeIai9vImaZVrsJbTHfTPWvIuMe13tbVrFzmtvgkrRK3Lir/k=
Message-ID: <1e62d137050915083396ae53@mail.gmail.com>
Date: Thu, 15 Sep 2005 20:33:41 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
Reply-To: fawadlateef@gmail.com
To: "Budde, Marco" <budde@telos.de>
Subject: Re: How to find "Unresolved Symbols"
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <809C13DD6142E74ABE20C65B11A2439809C4CA@www.telos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <809C13DD6142E74ABE20C65B11A2439809C4CA@www.telos.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/05, Budde, Marco <budde@telos.de> wrote:
> Hi,
> 
> I am working on a larger kernel module.
> This module will be based on a lot of
> portable code, for which I have to implement
> the OS depended code.
> 

Are you creating a module for multiple platforms or migrating an
existing one to new version ?? And what do u mean by OS dependent code
??? I think it might be Architecture dependent code !!!!

> At the moment I can compile the complete
> code into a module. Some of OS depended
> code is still missing, but I do not get
> any warnings from kbuild.
> 
> When I try to load the module, I can a really
> strange error message:
> 
>  insmod: error inserting 'foo.o': -795847932 Function not implemented
> 
> What does that mean? How can I get a list
> of missing symbols?
> 
> cu, Marco
> 

Plz tell which kernel version you are using and which distribution
!!!! b/c there is a probability that you distro might have old
modutils etc ......

-- 
Fawad Lateef
