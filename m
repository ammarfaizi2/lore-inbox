Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbSJHXK5>; Tue, 8 Oct 2002 19:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261450AbSJHXKI>; Tue, 8 Oct 2002 19:10:08 -0400
Received: from smtpout.mac.com ([204.179.120.86]:30444 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S261441AbSJHXJm> convert rfc822-to-8bit;
	Tue, 8 Oct 2002 19:09:42 -0400
Message-ID: <3DA36724.B5E62CB9@mac.com>
Date: Wed, 09 Oct 2002 01:15:48 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@mac.com>
Organization: B16
X-Mailer: Mozilla 4.79 [de] (X11; U; Linux 2.4.18-4GB-SMP i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, pthreads-devel@www-124.southbury.usf.ibm.com
Subject: Re: 2.5.40+ futex broken with COW
References: <3DA3589A.ED470EC5@mac.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Wächtler schrieb:
> 
> The COW changes break PROCESS_SHARED futexes in
> mmap( MAP_SHARED ).
> 
> I think that COW is unconditionally used on fork().
> But you need to check for MAP_SHARED, eh?
> 
> If wanted I can provide a testcase (that runs fine on
> 2.4.19+futex patch + NGPT and on Irix)

Argh, forget it. Made a silly mistake too painful to mention :)
