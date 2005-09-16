Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbVIPPRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbVIPPRE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 11:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbVIPPRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 11:17:04 -0400
Received: from qproxy.gmail.com ([72.14.204.194]:7449 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932443AbVIPPRD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 11:17:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N6GGh6l3RkeEiDbtWNwFfsW6FYJVQDvQcege+8sZSk3GOZYRB8x7/fKUdsAC9G0TtJel8mJnb3YEE+ktng/2hCQ/qYssF3cPvi3PV7Z0PXh0Zcrh494+ilAN4rcx5gN3S0m/xe0RqV9LM3HWk7IgWPtizFGhBYHWRRkivyFnbik=
Message-ID: <d120d50005091608171e06233@mail.gmail.com>
Date: Fri, 16 Sep 2005 10:17:00 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "abuisse@ens-lyon.fr" <abuisse@ens-lyon.fr>
Subject: Re: [patch] hdaps driver update, updated.
Cc: rml@novell.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050916155514.gtc8dd99kdi4gk4c@mouette.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050916155514.gtc8dd99kdi4gk4c@mouette.ens-lyon.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/05, abuisse@ens-lyon.fr <abuisse@ens-lyon.fr> wrote:
> On 9/14/05, Robert Love <rml@novell.com> wrote:
> 
>    On Wed, 2005-09-14 at 11:57 -0400, Robert Love wrote:
> 
>    Mr Morton,
> 
> > The hdaps driver landed in 2.6.14-rc1.
> >
> > The attached patch updates the driver:
> >
> >       - Remove the relative input device
> >       - Add an absolute input device
> >       - Misc. cleanup and bug fixing
> 
> 
> Hi,
> 
> I understand that the "echo 1 > mousedev" has changed and that we are now
> supposed to use joydev, but I can't find any joydev related thing in /sys.
> Could you please explain how using hdaps as an input device is now supposed to
> work ?
> 

I understand that it is now always activated. So just compile and load
joydev module and use /dev/input/jsX as your input device (joystick
type).

-- 
Dmitry
