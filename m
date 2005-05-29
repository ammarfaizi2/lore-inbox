Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVE2JWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVE2JWa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 05:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVE2JWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 05:22:30 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:63392 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261295AbVE2JWZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 05:22:25 -0400
In-Reply-To: <20050528095318.GA22962@nd47.coderock.org>
Subject: Re: [patch 4/10] s390: schedule_timeout cleanup in ctctty
To: Domen Puncer <domen@coderock.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFF69B5BA2.D76B2D8C-ONC1257010.0032D935-C1257010.00334C4E@de.ibm.com>
From: Frank Pavlic <PAVLIC@de.ibm.com>
Date: Sun, 29 May 2005 11:20:18 +0200
X-MIMETrack: Serialize by Router on D12ML068/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 29/05/2005 11:22:21
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Domen Puncer <domen@coderock.org> wrote on 28.05.2005 11:53:18:

> On 27/05/05 11:02 +0200, Frank Pavlic wrote:
> >
> > [patch 4/10] s390: schedule_timeout cleanup in ctctty.
> >
> > From: Domen Puncer <domen@coderock.org>
> >
> > Use msleep_interruptible() instead of schedule_timeout()
> > to guarantee the task delays as expected.
> >
> > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
>
> Actually it's from:
> Nishanth Aravamudan <nacc@us.ibm.com>
>
> Since then, I updated scripts to add the "From: " in the
> body, so this shouldn't be an issue in the future.
>
> > Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
> > Signed-off-by: Domen Puncer <domen@coderock.org>
> > Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>
> > Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> >
>
>
>    Domen

thank you for the correction ....

Frank

