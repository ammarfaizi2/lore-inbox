Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbVJRHWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbVJRHWo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 03:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbVJRHWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 03:22:44 -0400
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:48771 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751450AbVJRHWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 03:22:44 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.14-rc4-mm1
Date: Tue, 18 Oct 2005 02:22:41 -0500
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Brice Goglin <Brice.Goglin@ens-lyon.org>,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <20051016154108.25735ee3.akpm@osdl.org> <200510180209.49080.dtor_core@ameritech.net> <20051018071712.GA12145@kroah.com>
In-Reply-To: <20051018071712.GA12145@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510180222.41966.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 October 2005 02:17, Greg KH wrote:
> 
> Because before my patch, any class_device created for the input class,
> had the name, phys, and uniq attributes created for them, including the
> "simple" class device structures event0, event1, and so on.  The kobject
> being passed back to those callback functions was not of the same type
> of object as input0, input1 and so on.  So bad things happened.

Oh, I see. That's what you get for mixing devices of different classes
into one class ;)

-- 
Dmitry
