Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271887AbRIIEjw>; Sun, 9 Sep 2001 00:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271889AbRIIEjc>; Sun, 9 Sep 2001 00:39:32 -0400
Received: from mclean.mail.mindspring.net ([207.69.200.57]:531 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271887AbRIIEjZ>; Sun, 9 Sep 2001 00:39:25 -0400
Subject: Re: Feedback on preemptible kernel patch
From: Robert Love <rml@tech9.net>
To: Arjan Filius <iafilius@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109081920540.3542-100000@sjoerd.sjoerdnet>
In-Reply-To: <Pine.LNX.4.33.0109081920540.3542-100000@sjoerd.sjoerdnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.05.07.08 (Preview Release)
Date: 09 Sep 2001 00:40:02 -0400
Message-Id: <1000010407.840.35.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-09-08 at 13:33, Arjan Filius wrote:
> I tried 2.4.10-pre4 with patch-rml-2.4.10-pre4-preempt-kernel-1.
> But it seems to hit highmem (see below) (i do have 1.5GB ram)
> 2.4.10-pre4 plain runs just fine.

going through this thread and now looking at the highmem code, it is
clear highmem is not going to be preempt safe.

until Nigel or I (or someone?) can go through it all and add appropriate
locks, its a bomb waiting to blow.

thank you for the feedback...stay tuned.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

