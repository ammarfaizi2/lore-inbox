Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131850AbRAVX4w>; Mon, 22 Jan 2001 18:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135566AbRAVX4m>; Mon, 22 Jan 2001 18:56:42 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:60339 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131850AbRAVX4d>; Mon, 22 Jan 2001 18:56:33 -0500
Message-Id: <5.0.2.1.2.20010122233742.00ae5e40@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 22 Jan 2001 23:56:40 +0000
To: Mark I Manning IV <mark4@purplecoder.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [OT?] Coding Style
Cc: Stephen Satchell <satch@fluent-access.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3A6C630E.C2CB784C@purplecoder.com>
In-Reply-To: <4.3.2.7.2.20010122130852.00b92a80@mail.fluent-access.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 16:42 22/01/2001, Mark I Manning IV wrote:
>Stephen Satchell wrote:
> >                                              I got in the habit of using
> >  structures to minimize the number of symbols I exposed. It also
> > disambiguates local variables and parameters from file- and program-global
> > variables.
>
>explain this one to me, i think it might be usefull...

What might be meant is that instead of declaring variables my_module_var1, 
my_module_var2, my_module_var3, etc. you declare a struct my_module { var1; 
var2; var3; etc. }. Obviously in glorious technicolour formatting... (-;
That's my interpretation anyway...

Anton


-- 
      "Education is what remains after one has forgotten everything he 
learned in school." - Albert Einstein
-- 
Anton Altaparmakov  Voice: +44-(0)1223-333541(lab) / +44-(0)7712-632205(mobile)
Christ's College    eMail: AntonA@bigfoot.com / aia21@cam.ac.uk
Cambridge CB2 3BU    ICQ: 8561279
United Kingdom       WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
