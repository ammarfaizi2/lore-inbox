Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWFZOfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWFZOfr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWFZOfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:35:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:33626 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030239AbWFZOfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:35:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uVHvHDK0YH+9o14RH/xFMchi8fNR4+VxnAIgdvzNRW0d9Cmw61Wy4NlO/gSOI4bKrq0FPEpZeykCqhvfoxdbIGNIifwmI/V28juDBMP4wXUFgGYMST1yoc51M0wJpA9wa7mX8GWII0/TSzfFNkhhHza4WIrf7P2QsF361PPJ1nU=
Message-ID: <d120d5000606260735v6e1762d7mc278f315c3a994fb@mail.gmail.com>
Date: Mon, 26 Jun 2006 10:35:44 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: [PATCH] atkbd: restore autorepeat rate after resume
Cc: "Andrew Morton" <akpm@osdl.org>, "Vojtech Pavlik" <vojtech@suse.cz>,
       "Kernel development list" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0606261017340.9467-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.44L0.0606261017340.9467-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> From: Linus Torvalds <torvalds@osdl.org>
>
> This patch (as728) makes the AT keyboard driver store the current
> autorepeat rate so that it can be restored properly following a
> suspend/resume cycle.
>

Alan,

I think it should be a per-device, not global parameter. Anyway, I'll
adjust adn apply, thank you.

-- 
Dmitry
