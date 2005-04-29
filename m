Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262806AbVD2Q3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbVD2Q3e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 12:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbVD2Q3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 12:29:34 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:59429 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262806AbVD2Q3b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 12:29:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=taa5xVq7cB35YZurhw79lr6vJuWxhk0qZgN8bverIZrZtAkQuL2O2JOn2IeHp1kBw6dJoA/uPwJpTR48S2oyGmJE1cIs+zN6F5jPIUdkyfP9Pdwuos9yBWvvhRilcb4I1oUd7zWnj6f6MwoDMRM5Lsy+cZCnHWKY8/VHoaPVk+M=
Message-ID: <d120d500050429092934d3d748@mail.gmail.com>
Date: Fri, 29 Apr 2005 11:29:28 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: Serial Mouse in Kernel 2.6
In-Reply-To: <20050429162123.GB2592@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050429145248.3551b9ea.Christoph.Pleger@uni-dortmund.de>
	 <d120d5000504290903758bc9f2@mail.gmail.com>
	 <20050429162123.GB2592@animx.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/05, Wakko Warner <wakko@animx.eu.org> wrote:
> Dmitry Torokhov wrote:
> > If you load the modules and use input_attach program to set up your
> > mouse then you can access it via /dev/input/mice together with the
> 
> Where does one get the input_attach program?
> 

http://cvs.sourceforge.net/viewcvs.py/linuxconsole/ruby/utils/inputattach.c

I think RedHat packages it with GPM and Novell with input-utils. Not
sure about the others.

-- 
Dmitry
