Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280911AbRKYQPX>; Sun, 25 Nov 2001 11:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280907AbRKYQPM>; Sun, 25 Nov 2001 11:15:12 -0500
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:46728 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S280911AbRKYQPB>; Sun, 25 Nov 2001 11:15:01 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Severe Linux 2.4 kernel memory leakage
In-Reply-To: <Pine.LNX.4.40.0111251053390.7809-100000@yinyang.hjsoft.com>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 25 Nov 2001 17:14:56 +0100
In-Reply-To: <Pine.LNX.4.40.0111251053390.7809-100000@yinyang.hjsoft.com> ("Mr. Shannon Aldinger"'s message of "Sun, 25 Nov 2001 10:55:31 -0500 (EST)")
Message-ID: <tg7kseesjj.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mr. Shannon Aldinger" <god@yinyang.hjsoft.com> writes:

> Are you using tmpfs, that had problems in the earlier 2.4.x's IIRC.

I've seen tmpfs problems with 2.4.13+xfs, BTW: As soon as /tmp grows
so large that something has to be swapped out, the machine essentially
locks.  Known problem?

(I'm going to debug this some day and provide more details, but
currently, I'm busy setting up a new machine, and this one can't be
used for such testing any longer.)

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
