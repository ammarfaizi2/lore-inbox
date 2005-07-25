Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVGYOny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVGYOny (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 10:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVGYOnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 10:43:53 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:7767 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261239AbVGYOnk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 10:43:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L6ZvK//fGjZ37/5MAWIs/Xoph+8khsDBfQhw4ySD1JE+aj55gC5yTEfGOobtUFPW4HrI2y9uU3+b6ohH3XmVJHC3wV4/jKkPNM7iazQiS7sgq8CrAWObx5CBfv7X5tmZSFFL+tWSzzVacJiyUP0lrNf4VrhpDnvMifpyCa/v/k4=
Message-ID: <105c793f05072507426fb6d4c9@mail.gmail.com>
Date: Mon, 25 Jul 2005 10:42:45 -0400
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: "Francisco Figueiredo Jr." <fxjrlists@yahoo.com.br>
Subject: Re: "seeing minute plus hangs during boot" - 2.6.12 and 2.6.13
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050722182848.8028.qmail@web60715.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050722182848.8028.qmail@web60715.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/05, Francisco Figueiredo Jr. <fxjrlists@yahoo.com.br> wrote:
> Hangs appears just before mounting filesystems message and before configuring
> system to use udev.
I don't know if this will help, but there were issues raised earlier
about older versions of udev causing hangs on newer kernels. Look for
the thread with the subject "2.6.12 udev hangs at boot". Actually,
look here: http://marc.theaimsgroup.com/?l=linux-kernel&m=111909806104523&w=2

Basically, upgrade to a newer udev if you're running an older one (I
think I had 0.30 at the time; installing 0.58 sped things up
noticeably).

HTH.

-Andy
