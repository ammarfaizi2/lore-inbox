Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVDFNqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVDFNqd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 09:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVDFNqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 09:46:33 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:27512 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262205AbVDFNqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 09:46:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=OAo++BUExtJgbO9hGHaEubeFxdIlAM1tXiMD8ogZivg8WQE6T6Sokb56wAw92dCM5fnNG2ywVoko6jjn8WXV3iTED0UWbwJcYzZYQxhrDlB4yIOLbZ84gGZ/tZyT963OXyYvE5r2SVLId4i/7fBpB7PNi04r8NPBZc24TsO/EcI=
Message-ID: <40f323d0050406064617b0f98f@mail.gmail.com>
Date: Wed, 6 Apr 2005 09:46:30 -0400
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: Joe Button <vger.kernel.org@joebutton.co.uk>
Subject: Re: 2.6.12-rc1: Mouse stopped working
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200504061319.39431.vger.kernel.org@joebutton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <200504061319.39431.vger.kernel.org@joebutton.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 6, 2005 8:19 AM, Joe Button <vger.kernel.org@joebutton.co.uk> wrote:
> Hi.
> 
> My mouse stopped working in x.org with 2.6.12-rc1. Problem is still there in
> 2.6.12-rc2. Works on 2.6.11.x with same .config (except for make oldconfig /
> defaults).
> 
> Mouse is ImPs2, xorg.conf is using /dev/input/mouse0, which seems to be
> present. Board is Asus p4p800 deluxe.
> 
Maybe you can try using /dev/input/mice, or if there is one, /dev/input/mouse1.

regards,

Benoit
