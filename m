Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263111AbTCLI4d>; Wed, 12 Mar 2003 03:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263112AbTCLI4c>; Wed, 12 Mar 2003 03:56:32 -0500
Received: from elin.scali.no ([62.70.89.10]:42681 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S263111AbTCLI4A>;
	Wed, 12 Mar 2003 03:56:00 -0500
Subject: Re: User Process and a Kernel Thread
From: Terje Eggestad <terje.eggestad@scali.com>
To: Prasad <prasad_s@students.iiit.net>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303111559001.26984-100000@students.iiit.net>
References: <Pine.LNX.4.44.0303111559001.26984-100000@students.iiit.net>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1047459991.26850.1261.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 12 Mar 2003 10:06:31 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You should have very good reasons for making a kernel thread. 
As in "it can't be done in userspace".

When running a kernel thread you have "process" that is 
a) using the kernel memory, not it own private
b) the CPU is in privilege mode, not user mode
c) libc don't exist

If you don't understand the difference between kernel mode and user
mode, your question suggest you don't, read chapter two in 
http://www.xml.com/ldd/chapter/bookindexpdf.html
and please keep of lkml, and direct you questions to the kernelnewbie
list : http://www.kernelnewbies.org/

Terje

On Tue, 2003-03-11 at 11:32, Prasad wrote:
> Hi all,
> 	Whats the difference between the user process and a kernel thread? 
> IS it possible to make the kernel thread a user process? if yes, how do we 
> do that?
> 
> Prasad.
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

