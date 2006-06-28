Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423288AbWF1LvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423288AbWF1LvF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 07:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423284AbWF1LvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 07:51:05 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:31664 "EHLO
	asav05.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1423288AbWF1LvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 07:51:02 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAFwIokSBSg
From: Dmitry Torokhov <dtor@insightbb.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: broken auto-repeat on PS/2 keyboard
Date: Wed, 28 Jun 2006 07:50:58 -0400
User-Agent: KMail/1.9.3
Cc: "Dmitry Torokhov" <dtor_core@ameritech.net>,
       LKML <linux-kernel@vger.kernel.org>,
       "Paolo Ornati" <ornati@fastwebnet.it>
References: <20060627162733.551f844f@localhost> <d120d5000606271034l693567a3r23d892204d5fd3f7@mail.gmail.com> <20060628133630.e7e1f754.khali@linux-fr.org>
In-Reply-To: <20060628133630.e7e1f754.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606280750.59747.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 June 2006 07:36, Jean Delvare wrote:
> Hi Dmitry,
> 
> > > with current git kernel keyboard repeat for my plain PS/2 keyboard
> > > stopped working.
> > >
> > > Reverting
> > >        0ae051a19092d36112b5ba60ff8b5df7a5d5d23b
> > >
> > > fixes the problem...
> > 
> > Thank you for identifying the problem commit. Please try the attached
> > patch, it should fix the problem.
> 
> Fixed it for me as well, thanks! Can this fix be pushed upstream now?
> The lack of repeat was a real pain.
> 

Heh, that means noone but me uses softrepeat option, I didn't even notice
it was broken. ;)

I already sent pull request to Linus so you should see it soon.
 
-- 
Dmitry
