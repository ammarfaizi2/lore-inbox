Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133053AbRDRIRK>; Wed, 18 Apr 2001 04:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133054AbRDRIRA>; Wed, 18 Apr 2001 04:17:00 -0400
Received: from h170n1fls20o70.telia.com ([213.64.50.170]:53154 "EHLO
	garbo.localnet") by vger.kernel.org with ESMTP id <S133053AbRDRIQm>;
	Wed, 18 Apr 2001 04:16:42 -0400
Message-ID: <3ADD4D46.3E8CF0B2@canit.se>
Date: Wed, 18 Apr 2001 10:16:06 +0200
From: Kenneth Johansson <ken@canit.se>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Manfred Bartz <md-linux-kernel@logi.cc>, linux-kernel@vger.kernel.org
Subject: Re: IP Acounting Idea for 2.5
In-Reply-To: <E14pef6-0003Vj-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > > Fix your userspace applications to behave correctly.  If _you_
> > > require your userspace applications to not clear counters, then fix
> > > the application.
> >
> > You are confused.  What would you say if a close() by another,
>
> No he isnt confused, you are trying to dictate policy.

Well it's not actually possible to do a fix in userspace for a odometer type of counter that can be reset. I don't know what you mean about policy but this reset "feature" is a shure way to get bad values. I have not seen one good reason to have a reset other than it easier to read and that is something that can be fixed in userspace.

