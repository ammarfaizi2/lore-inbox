Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316158AbSFJUeg>; Mon, 10 Jun 2002 16:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSFJUef>; Mon, 10 Jun 2002 16:34:35 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:50694 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S316158AbSFJUee>; Mon, 10 Jun 2002 16:34:34 -0400
Subject: Re:  2.5.21: "ata_task_file: unknown command 50"
From: Miles Lane <miles@megapathdsl.net>
To: Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3D04777D.2040705@st-peter.stw.uni-erlangen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 10 Jun 2002 13:32:07 -0700
Message-Id: <1023741128.1793.0.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-10 at 02:55, Svetoslav Slavtchev wrote:
> >raid0_make_request bug: can't convert block across chunks or bigger than 
> >64k 94712 8
> >raid0_make_request bug: can't convert block across chunks or bigger than 
> >64k 1340144 12
> >raid0_make_request bug: can't convert block across chunks or bigger than 
> >64k 1342192 20
> 
> that's a problem of the raid-0 code
> it needs a request splitter and/or more bio changes
> it's here since 2.5.5 AFAIK 
> are you using raid
> 
> i'm useing lvm over soft raid-0 and i can not mount my
> xfs LV's because of that

Yeah, I am using software raid0, as well.

	Miles

