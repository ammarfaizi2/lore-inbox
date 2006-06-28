Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932781AbWF1Lg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932781AbWF1Lg1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 07:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932783AbWF1Lg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 07:36:27 -0400
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:34310 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932781AbWF1Lg0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 07:36:26 -0400
Date: Wed, 28 Jun 2006 13:36:30 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Dmitry Torokhov" <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>, "Paolo Ornati" <ornati@fastwebnet.it>
Subject: Re: broken auto-repeat on PS/2 keyboard
Message-Id: <20060628133630.e7e1f754.khali@linux-fr.org>
In-Reply-To: <d120d5000606271034l693567a3r23d892204d5fd3f7@mail.gmail.com>
References: <20060627162733.551f844f@localhost>
	<d120d5000606271034l693567a3r23d892204d5fd3f7@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> > with current git kernel keyboard repeat for my plain PS/2 keyboard
> > stopped working.
> >
> > Reverting
> >        0ae051a19092d36112b5ba60ff8b5df7a5d5d23b
> >
> > fixes the problem...
> 
> Thank you for identifying the problem commit. Please try the attached
> patch, it should fix the problem.

Fixed it for me as well, thanks! Can this fix be pushed upstream now?
The lack of repeat was a real pain.

-- 
Jean Delvare
