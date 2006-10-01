Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWJAMxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWJAMxr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 08:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWJAMxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 08:53:47 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:56353 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932151AbWJAMxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 08:53:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mS5oNV8pMkH+vrTGQxav1cRNmmwBis5p1BEg0DqMt91+u3BUKDpXQmI4PTuQdFUFacj4AFrWeNVpg+YIh6LJG0M0bcjDQ32h3k75NbEOCARDxt9pwzh+PrGTzX4alOe9KjD06LvbVFbz0Kr+TMI257nwKLGq6c35dfV+Mi9ByNU=
Message-ID: <653402b90610010553p23819d2bsd7a07fabaee7ecf3@mail.gmail.com>
Date: Sun, 1 Oct 2006 14:53:45 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: akpm@osdl.org
Subject: Re: [PATCH 2.6.18 V7] drivers: add lcd display support
Cc: "Stefan Richter" <stefanr@s5r6.in-berlin.de>,
       "Randy Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20060930232445.59e8adf6.maxextreme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060930232445.59e8adf6.maxextreme@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>
> It is as common as it is wrong. http://en.wikipedia.org/wiki/RAS_Syndrome
>
> A contraction like LCDisplay, like my suggested lcdisplay for the path
> name, is IMO not suitable for use in normal written language. Use it at
> most for path names where we contract words into one or would write
> lc-display or lc_display.
>
> Still wrong language.
>
> "LCD" and "LC display" are correct.
>

Sure it is wrong, the point is what is the best to understading. "LCD
display" seems better to me than just "LC display".

Maybe "drivers/lcdisplay" and "LCD" in common written places? Then we will have:

tristate "ks0108 LCD controller"
tristate "cfag12864b LCD"

That is the correct spelling, however, does it look good?

(I really don't know what is the best way to write it in english, I'm
spanish and here it is more common to say "LCD display").
