Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263200AbVBCONq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbVBCONq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 09:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263284AbVBCONp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 09:13:45 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:19413 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263200AbVBCONc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 09:13:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=qBoBz6Bz233aDRxkjutvDK+v/o3TUCl0/vjeZhkbNcsksjJacduTompJK94vuOU8mXo2fp/C1K3Fn2lyKHx/YKibO+aPnCNUh4rUUTI3bLuCLxPd2CnMkaqrfxvEgn58bqG3Cu9atgY8Du8YYoYklOjgMuoLCrSe6qtH9bjUNds=
Message-ID: <58cb370e05020306132afcabf8@mail.gmail.com>
Date: Thu, 3 Feb 2005 15:13:28 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 11/29] ide: add ide_drive_t.sleeping
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050202025448.GL621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202025448.GL621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 11:54:48 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 11_ide_drive_sleeping_fix.patch
> >
> >       ide_drive_t.sleeping field added.  0 in sleep field used to
> >       indicate inactive sleeping but because 0 is a valid jiffy
> >       value, though slim, there's a chance that something can go
> >       weird.  And while at it, explicit jiffy comparisons are
> >       converted to use time_{after|before} macros.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
