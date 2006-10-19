Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946373AbWJSS56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946373AbWJSS56 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946376AbWJSS56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:57:58 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:37535 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1946373AbWJSS55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:57:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IcOklVAAlWEaYnHz2vo/BsCmbiXQ+ghZ6/CqvunM2Kmki9yvrdJChwNY928ZKUDTjlMk9VlpvhpCn69lCLTWGgFxf9E/t/BuZDM8YTAoAkUpP2tIwb8/rWi3o2cEFbMTTqejNecmz1gUt0R8Vw9FMgj8WW0TcZwv6ypOQvtOQdk=
Message-ID: <806dafc20610191157w64273b5eu294c936c302fc1dc@mail.gmail.com>
Date: Thu, 19 Oct 2006 14:57:56 -0400
From: "Christopher \"Monty\" Montgomery" <xiphmont@gmail.com>
To: "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.19-rc1-mm1 - locks when using "dd bs=1M" from card reader
Cc: "Helge Hafting" <helge.hafting@aitel.hist.no>,
       "Paolo Ornati" <ornati@fastwebnet.it>,
       "Kernel development list" <linux-kernel@vger.kernel.org>,
       "USB development list" <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0610191416470.8183-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45376EC4.3080807@aitel.hist.no>
	 <Pine.LNX.4.44L0.0610191416470.8183-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/06, Alan Stern <stern@rowland.harvard.edu> wrote:

> Monty has been making changes to this driver recently; maybe he has some
> ideas about the problem.

I have been watching the thread worried that this is due to a change
I've made.  However, I should not have done anything to change
handling on the async queue-- at least, I've not made any changes
intentionally, which is not the same thing as not making any changes.

I'll also be interested to see the result of the additional debug message.

Monty
