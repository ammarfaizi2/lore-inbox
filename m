Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282395AbRLCIvd>; Mon, 3 Dec 2001 03:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284515AbRLCIu5>; Mon, 3 Dec 2001 03:50:57 -0500
Received: from rj.SGI.COM ([204.94.215.100]:29411 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S284631AbRLCCDn>;
	Sun, 2 Dec 2001 21:03:43 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: esr@thyrsus.com
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5 
In-Reply-To: Your message of "Sun, 02 Dec 2001 20:19:46 CDT."
             <20011202201946.A7662@thyrsus.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Dec 2001 13:03:32 +1100
Message-ID: <2313.1007345012@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Dec 2001 20:19:46 -0500, 
"Eric S. Raymond" <esr@thyrsus.com> wrote:
>Keith Owens <kaos@ocs.com.au>:
>> The CML1 to CML2 conversion comes later, either in 2.5.3 or 2.5.4.
>
>The schedule I heard from Linus at the kernel summit was that both changes 
>were to go in between 2.5.1 and 2.5.2.   I would prefer sooner than later 
>because I'm *really* *tired* of maintaining a parallel rulebase.

I have not got CML2 support working in kbuild 2.5 so I left a bit of
room between kbuild 2.5 going in and cutting over to CML2.  _If_ I can
get CML2 support working before 2.5.1 comes out then we go

  2.5.2-pre1 Add kbuild 2.5 with both CML1 and CML2 support.
  2.5.2-pre2 Remove kbuild 2.4.
  2.5.2-pre3 Remove CML1.
  2.5.2

I would prefer that sequence myself, but I don't want to promise a
timetable that I cannot deliver.

