Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVC2QVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVC2QVo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 11:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVC2QVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 11:21:44 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:35178 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261183AbVC2QVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 11:21:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=GVnk6WZbdWkWmHyCnYg0oEh7+YKrjNW3P4LIg34RZmEgPMoneQEbv15wPcxSSV09sxZFWJMzsgek6nj/jsruCZYdIQwZdkktA1ULsP6p3Tr6xINaJ/8+1PpWD/0cf4/bBoxAjKEaj7NhJ4FO5l6soeGTMz432DvLEZGLxN46s1g=
Message-ID: <d120d5000503290821414ec099@mail.gmail.com>
Date: Tue, 29 Mar 2005 11:21:36 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vernon Mauery <vernon@mauery.com>
Subject: Re: Keystroke simulator
Cc: Mister Google <binary-nomad@hotmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <42497D1D.5090301@mauery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <BAY10-F55DA0F654CE67C2B4DC2F684450@phx.gbl>
	 <42497D1D.5090301@mauery.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2005 08:06:53 -0800, Vernon Mauery <vernon@mauery.com> wrote:
> Mister Google wrote:
> > Is there a way to simulate a keystroke to a program, ie. have a program
> > send it something so that as far as it's concerned, say, the "P" key has
> > been pressed?
> >
> Look at the input system.  Documentation/input/input-programming.txt has a great tutorial on how to do this.
> 

You probably will want to write a program using uinput driver to
inject events into input subsystem from userspace. Then the rest of
the world will not be able to recognize whether the data comes from
your program of from a real keyboard.

-- 
Dmitry
