Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbVLIM25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVLIM25 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 07:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVLIM25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 07:28:57 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:20175 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751196AbVLIM24 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 07:28:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jkFDdBzL3+CbL+2lwNb5se62Q5lo5PB8hO+DagNGOm834N261fM0IU52cSJSFjQYdX3cguP6nQm9cKTbTzf4H/XSqD8ZnZr50LuyLIlG6/4FOUzSFFmdxglAgcIsdUessMXLt2NTSlPK53xE77k2siB9qL/WCep4NTpPEXZXazM=
Message-ID: <81b0412b0512090428y4d525b54lf4cd7a7048107cb2@mail.gmail.com>
Date: Fri, 9 Dec 2005 13:28:55 +0100
From: Alex Riesen <raa.lkml@gmail.com>
To: Deven Balani <devenbalani@gmail.com>
Subject: Re: recording with out getting into user space.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7a37e95e0512090057v5c2ab4cdwf1711144058cc77f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7a37e95e0512090057v5c2ab4cdwf1711144058cc77f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/05, Deven Balani <devenbalani@gmail.com> wrote:
> I am writing a libata-complaint SATA driver for an ARM board.
>
> I want to do data streaming from a tuner into the SATA hard disk.
>
> In other words, I am getting a buffer of stream in kernel space, which
> I had to store it in SATA hard disk.

can this be of interest:

http://groups.google.de/group/fa.linux.kernel/browse_frm/thread/21b2b3215f35e21a/bcbc00b7a0151afd?tvc=1&q=linux-kernel+Make+pipe+data+structure+be+a+circular+list+of+pages#bcbc00b7a0151afd
