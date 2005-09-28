Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbVI1Qmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbVI1Qmw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 12:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbVI1Qmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 12:42:52 -0400
Received: from qproxy.gmail.com ([72.14.204.207]:54801 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751429AbVI1Qmv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 12:42:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uTS7JNRIdFBmg2dpf1EMmW+ieIMQ0iPG6zzGUeYtHuAxU/RWsc8KHX6+HnIepJH8sFPa85dIsCWUclN98j0RUz8m86s/w/RgggOrY8fz3Lo0MGZH26qbJHbQQ7OUyFt0J3yGc1boj5GUvyNmqP65guiG3cC6SQcyZqMFiJdaAI4=
Message-ID: <98b62faa05092809423ac837bc@mail.gmail.com>
Date: Wed, 28 Sep 2005 09:42:50 -0700
From: <iodophlymiaelo@gmail.com>
Reply-To: iodophlymiaelo@gmail.com
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: raw aio write guarantee
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200509280923.j8S9Nkgq028579@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <98b62faa050928001275d28771@mail.gmail.com>
	 <200509280757.j8S7vmjB023730@turing-police.cc.vt.edu>
	 <98b62faa050928015677d7253b@mail.gmail.com>
	 <200509280923.j8S9Nkgq028579@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/05, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Wed, 28 Sep 2005 01:56:05 PDT, iodophlymiaelo@gmail.com said:
>
> > I was asking what a user-application can do to prevent data loss, not
> > an application-user.
>
> Right.  However, if you actually care about the distinction between "made it
> to the disk cache" and "made it to the platter", those are things you'll
> want to address - in particular, if you have one of the evil disk drives
> I mentioned, there's very little a user application can do to work around it.
>

Erm, is the hardware problem really as great as you're implying? Have you
personally encountered any bad drives made by reputable brands? Mostly I've
only heard only of people crying wolf and then realizing it was a problem with
their reasoning or with the assumption that fsync() actually works properly on
kernel X, where X doesn't even have to be that ancient a version of linux ;-)
