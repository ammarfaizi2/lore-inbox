Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWAIJTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWAIJTI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 04:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWAIJTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 04:19:08 -0500
Received: from jack.kinetikon.it ([62.152.125.81]:35730 "EHLO
	mail.towertech.it") by vger.kernel.org with ESMTP id S1751133AbWAIJTI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 04:19:08 -0500
Date: Mon, 9 Jan 2006 10:14:31 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] RTC subsystem, dev interface
Message-ID: <20060109101431.16105996@inspiron>
In-Reply-To: <200601090139.29556.dtor_core@ameritech.net>
References: <20060108231235.153748000@linux>
	<200601082150.22213.dtor_core@ameritech.net>
	<20060109041206.6115bafb@inspiron>
	<200601090139.29556.dtor_core@ameritech.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006 01:39:29 -0500
Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> >  What the code implements is actually an interface, so this should
> >  be the riht place. It is also fully optional, everything could work
> >  without it. Probably the interface implementation hasn't all the primitives
> >  to handle this kind of work, but I'm not willing to go into that right now ;)
> > 
> 
> Yes, it is an interface. What I am trying to say - is it a main interface?
> What is the preferred, most efficient way to interface with RTC? If it is
> through this interface it may make sence to fold it into the core. Otherwise
> do what input layer does and have interface create another class device which
> reprsesents your /dev node.

 I think it depends on what you want to do. On desktop systems is certainly
 the dev interface, on some embedded you may want to go via sysfs.

 I would keep it that way until the system can react on a change of
 the dev attribute.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

