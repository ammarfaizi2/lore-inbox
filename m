Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273918AbRJBNq7>; Tue, 2 Oct 2001 09:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274134AbRJBNqt>; Tue, 2 Oct 2001 09:46:49 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:40489 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274079AbRJBNqk>; Tue, 2 Oct 2001 09:46:40 -0400
Subject: Re: Athlon optimized kernels?
From: Robert Love <rml@tech9.net>
To: DevilKin <devilkin@gmx.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011002115402.00ad1c88@pop.gmx.net>
In-Reply-To: <5.1.0.14.2.20011002115402.00ad1c88@pop.gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.30.08.08 (Preview Release)
Date: 02 Oct 2001 09:47:05 -0400
Message-Id: <1002030427.865.41.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-10-02 at 05:56, DevilKin wrote:
> Hello All,
> 
> I presume that this has been asked here numerous times before, but I'm on a 
> rather limited internet connection (besides mail, that is) and well...
> 
> I've been hearing a lot here lately about optimized kernels for Athlons. Is 
> this a kernel patch of some sort? And where can I find it - as I have a 
> thunderbird system, I would love to try those out and help finding bugs in
> it!

No, Athlon optimized means you enabled CONFIG_MK7.  See `make xconfig'
-> Processor Type and Features -> CPU Type

This enables Athlon-specific features where appropriate, and instructs
gcc to compile for an Athlon CPU.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

