Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbREOPpM>; Tue, 15 May 2001 11:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262797AbREOPow>; Tue, 15 May 2001 11:44:52 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:46349
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S262796AbREOPol>; Tue, 15 May 2001 11:44:41 -0400
Date: Tue, 15 May 2001 11:43:19 -0400
From: Chris Mason <mason@suse.com>
To: Samium Gromoff <_deepfire@mail.ru>,
        "Vladimir V. Saveliev" <monstr@namesys.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Re[2]: ReiserFS 2.4.4/3.x.0k-pre2
Message-ID: <1078540000.989941399@tiny>
In-Reply-To: <E14zc0K-0000ya-00@f6.mail.ru>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, May 15, 2001 02:24:36 PM +0400 Samium Gromoff
<_deepfire@mail.ru> wrote:

>           Hello,
>      I`m still experiencing file tail corruptions
>   on subj.
>      And more: after i had restored bblocked patrition
>   (by relying on drive`s ability to remap bblks on
>   write by wroting small modification of debugreiserfs
>   which zeroified all bblks), i had _runtime_ tail
>    corruptions of the mc`s dir hotlist which i tried 
>    to rewrite again and again.
>   i found, that "sync"ing after modifying helps to keep
>   file fine, so it does until now.

Hmmm, are you sure the disk is good now?

What kinds of things are you doing on the files where you see tail
corruptions?  Can you reliably reproduce the corruption?

-chris

