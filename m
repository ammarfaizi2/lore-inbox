Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289346AbSBJHvp>; Sun, 10 Feb 2002 02:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289342AbSBJHvh>; Sun, 10 Feb 2002 02:51:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2055 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289346AbSBJHvU>;
	Sun, 10 Feb 2002 02:51:20 -0500
Message-ID: <3C66263E.B4535C5D@zip.com.au>
Date: Sat, 09 Feb 2002 23:50:22 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pawel Worach <pawel.worach@telia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-pre9
In-Reply-To: <3C662264.9090207@telia.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel Worach wrote:
> 
> during an cvs update of the mozilla source tree the machine oops'ed and
> hung hard. system is a abit bp6 with two intel celeron cpu's. this seems
> to be swap/cache related, memory has been tested with memtest86 without
> any faults
> 
> ../Pawel
> 
> decoded oops:
> 
> VM: killing process sendmail

Well that's interesting.  You got an out-of-memory kill.  Does
that happen often?

For how long did you run memtest86?  If it was less than 12 hours,
could you please give it an overnight run and let me know the
results?

Also, could you please send me your .config, and a description
of what sort of things the machine is used for?

Are you using netfilter?   If so, was it in use at the time
of the crash?  And if so, what netfilter modules were you
using?

Thanks!
