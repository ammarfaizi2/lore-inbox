Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932654AbWFUTA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbWFUTA6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWFUTA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:00:57 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:63972 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932654AbWFUTA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:00:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sqJtFLkV2DYYpPaLeLe76aP5aZ+AlYxL93W/0/U8PFGsWpzjJCCxAwGD3/MP2EfNE4cI/jSizGT0xUjG9+boFg2JLtZhpBKRNWd5YSe6gYH0k7nhPBqla2TrkTu3YwXweu//QpibSjOhUZ4gBhZp0qLZFyZwxDxV8nQPVI6fLyU=
Message-ID: <7c3341450606211200k5134c3fag286bc0b9b61d05aa@mail.gmail.com>
Date: Wed, 21 Jun 2006 20:00:55 +0100
From: "Nick Warne" <nick.warne@gmail.com>
Reply-To: nick@linicks.net
To: "Piotr Kaczuba" <pepe@attika.ath.cx>
Subject: Re: PC speaker doesn't work
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060621111430.GA5753@attika.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060619171544.GA4363@attika.ath.cx>
	 <20060621111430.GA5753@attika.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You know, I am glad you posted this, as my system bell stopped working
ages ago and I didn't know why (I am on x86 though).

So this post is in case anybody else has this peculiar problem.

I didn't have a CONFIG_INPUT_PCSPKR in my .config, so investigated...

It is cunningly hidden in Device Drivers->Input device
support->Miscellaneous devices->PC Speaker support

Then to get KDE to use it (I used KDE sound to *beep* before I sussed
this tonight), even more peculiar configuration is required:

http://lists.kde.org/?l=kde-accessibility&m=110963809201407&w=2

All now works!  I did really miss the beeps for some silly reason...

Nick
