Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWCVJza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWCVJza (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 04:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWCVJza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 04:55:30 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:55728 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751173AbWCVJz3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 04:55:29 -0500
Subject: Re: 2.6.16-rt1
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Wed, 22 Mar 2006 10:59:07 +0100
Message-Id: <1143021547.4668.46.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 22/03/2006 10:57:17,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 22/03/2006 10:57:20,
	Serialize complete at 22/03/2006 10:57:20
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi,

  when testing 2.6.16-rt1, I noticed schedule_hrtimer() disappeared from
hrtimer.c. I was exporting and using it for a custom application so I had
to fall back to reimplementing the same functionality where it was needed.

  On a more general note, wouldn't it be usefull to have that kind of
function available to the rest of the kernel?

  Sébastien.

-- 
-----------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
                   http://sourceforge.net/projects/paiol

-----------------------------------------------------

