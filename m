Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423283AbWF1LsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423283AbWF1LsS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 07:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423287AbWF1LsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 07:48:17 -0400
Received: from aa003msr.fastwebnet.it ([85.18.95.66]:41382 "EHLO
	aa003msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1423283AbWF1LsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 07:48:17 -0400
Date: Wed, 28 Jun 2006 13:48:04 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Jean Delvare <khali@linux-fr.org>
Cc: "Dmitry Torokhov" <dtor_core@ameritech.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: broken auto-repeat on PS/2 keyboard
Message-ID: <20060628134804.681a2fb0@localhost>
In-Reply-To: <20060628133630.e7e1f754.khali@linux-fr.org>
References: <20060627162733.551f844f@localhost>
	<d120d5000606271034l693567a3r23d892204d5fd3f7@mail.gmail.com>
	<20060628133630.e7e1f754.khali@linux-fr.org>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 13:36:30 +0200
Jean Delvare <khali@linux-fr.org> wrote:

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

http://groups.google.it/group/linux.kernel/browse_frm/thread/17700355fcda1923/05f38a40a23d0ef1?lnk=st&q=group%3Alinux.kernel+author%3ADmitry&rnum=1&hl=en#05f38a40a23d0ef1

-- 
	Paolo Ornati
	Linux 2.6.17-ga39727f2-dirty on x86_64
