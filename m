Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWJARwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWJARwh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 13:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWJARwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 13:52:37 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:62709 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932127AbWJARwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 13:52:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EFDrxs8D5kJNEThKGsMjP9JLQ6mvI2nUOLbj4paPcF32Cqq9Byq/xa5RU3Jn2rf0GV5bJj08BSvwhnec7rW1NAOZEGBM0wl1M6TBPj+fN5uAEVow/a83tMFWIpmwh8VtzZeXGo7hg13PD8tlm93lPK91mjyxyTDG3tVLn/KGo48=
Message-ID: <653402b90610011052o24574dd5o4cb911f118e8adfd@mail.gmail.com>
Date: Sun, 1 Oct 2006 19:52:35 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Alexander van Heukelum" <heukelum@fastmail.fm>
Subject: Re: [PATCH 2.6.18 V7] drivers: add lcd display support
Cc: "Randy Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       "Stefan Richter" <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu
In-Reply-To: <1159723673.14141.272274719@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060930232445.59e8adf6.maxextreme@gmail.com>
	 <653402b90610010553p23819d2bsd7a07fabaee7ecf3@mail.gmail.com>
	 <451FC7DC.7070909@s5r6.in-berlin.de>
	 <200610011605.k91G5wJD031632@turing-police.cc.vt.edu>
	 <20061001094342.55a331d1.rdunlap@xenotime.net>
	 <1159723673.14141.272274719@webmail.messagingengine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/06, Alexander van Heukelum <heukelum@fastmail.fm> wrote:
> I think there is a problem with the name anyhow. Would you use the
> LCD(d)isplay driver for an OLED screen?
>
> How about auxiliary display or AUXdisplay?
>
> Alexander
>

Mi first guess was drivers/display/, to put driver about
extra-displays, not only LCDs.

But people thought it can confuse users, so I chose to add "LCD" to be
more specific.

And no, it is not an organic screen. It is for a cfag12864b LCD
(Liquid Crystal Display):

http://www.crystalfontz.com/products/12864b/index.html
