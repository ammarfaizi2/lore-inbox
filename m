Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755309AbWKMSUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309AbWKMSUl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755310AbWKMSUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:20:40 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:55683 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1755309AbWKMSUk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:20:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i16bE6/2CvlPpZ0fkSs4fviIQcxuA5TPdcH3YCiUEeE3FSnC+xXRSgjZovm2Jn36U4Bru3oPFAQ/mSApffrba651jZ69tfY6LFwGGprRzkfbkHda8qUYZxlAeIOGyP6MBWhvXID5ygAZDAlv/gv9aRhPWkmy1nWWdjaqrqZ0ASM=
Message-ID: <d120d5000611131020y69bdada1hfe694583312f9b61@mail.gmail.com>
Date: Mon, 13 Nov 2006 13:20:37 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Stelian Pop" <stelian@popies.net>
Subject: Re: [PATCH] Apple Motion Sensor driver
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Michael Hanselmann" <linux-kernel@hansmi.ch>,
       "Aristeu S. Rozanski F." <aris@cathedrallabs.org>,
       "Johannes Berg" <johannes@sipsolutions.net>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Paul Mackerras" <paulus@samba.org>, "Robert Love" <rml@novell.com>,
       "Jean Delvare" <khali@linux-fr.org>,
       "Rene Nussbaumer" <linux-kernel@killerfox.forkbomb.ch>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <1163434455.23444.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <1163280972.32084.13.camel@localhost.localdomain>
	 <d120d5000611130704r258c8946p3994c5ba1e0187e9@mail.gmail.com>
	 <1163431758.23444.8.camel@localhost.localdomain>
	 <d120d5000611130753p172c2a69n260482052f623a46@mail.gmail.com>
	 <1163434455.23444.14.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/06, Stelian Pop <stelian@popies.net> wrote:
> Le lundi 13 novembre 2006 à 10:53 -0500, Dmitry Torokhov a écrit :
>
> > > +       return IS_ERR(ams_info.kthread) ? -ENODEV : 0;
>
> > Is there a reason why you reporting -ENODEV instead of real error code
> > from kthread_run()?
>
> Euh... :)
>
> Here it comes again:
>

Great :) Now I wonder if I may ask you to change name of the module
option from "mouse" to "joystick" (HP driver uses this name as well)
because its functionality is closer to a joystick than a mouse.

Otherwise you can have my Acked-by for the input part.

-- 
Dmitry
