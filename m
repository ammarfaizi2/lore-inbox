Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286011AbRLHWk3>; Sat, 8 Dec 2001 17:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286024AbRLHWkY>; Sat, 8 Dec 2001 17:40:24 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:12012 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S286011AbRLHWkO>; Sat, 8 Dec 2001 17:40:14 -0500
Message-ID: <3C114539.62A0D8E7@sympatico.ca>
Date: Fri, 07 Dec 2001 17:39:53 -0500
From: Chris Friesen <chris_friesen@sympatico.ca>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: software raid issues -- possible kernel I/O problem?
In-Reply-To: <3C11358D.28400117@sympatico.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A number of people have privately pointed out that hdparm -T doesn't
actually go to the disk at all.  Guess I should RTFM...I though that
this was reading from the disk's cache, not linux's cache.  Oops.

I'm still kind of curious why raid-1 reads don't seem to get any
performance increase over reads from a single disk.  Any ideas?

Chris
