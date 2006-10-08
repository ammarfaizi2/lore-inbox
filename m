Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWJHShb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWJHShb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 14:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWJHShb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 14:37:31 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:14722 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751319AbWJHSha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 14:37:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kb/Mtp+VHJhEaQ6WhR3kxpCKdtSbUSRxdcpzZ72aYvauaX6l6E4MOxF2DXu8WXdxQ4E4tn2AyFAD9ZxrDlAXfiSi2GjcP00hj07ZkpTfk4BJLGOeH/pYKbqFrPn1WulzXpwfhI14qWFU4hWA9pMAIRi1RGi9Ma+iw/mIyalYoY4=
Message-ID: <653402b90610081137g7885fc85h54e5e94de682a246@mail.gmail.com>
Date: Sun, 8 Oct 2006 20:37:29 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [PATCH 2.6.19-rc1 V9] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061008182438.GA4033@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061006002950.49b25189.maxextreme@gmail.com>
	 <20061008182438.GA4033@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/06, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> No, I'm sorry. And I have to apologize for being blind.
>
> I was going to say 'this is very important, because cellphones *do*
> have secondary displays, and we want to use them'. And yes it is
> important, but you got the interface wrong.
>
> So you have 128x64 pixels b/w display, and invented completely new
> interface to control it.
>
> Fortunately we already have good interface for the display... It is
> called fbcon, and is more flexible than 128x64 b/w... but can do
> 128x64 b/w just fine.
>
> Please use it. It is way more flexible, and it is right thing to do.
>
>                                                 Pavel
>

Hum, excuse me if I haven't understood you, but this LCD has nothing
to do with cellphones or fbcon.
