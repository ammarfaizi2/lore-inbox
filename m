Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135770AbRDTH5p>; Fri, 20 Apr 2001 03:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135763AbRDTH5h>; Fri, 20 Apr 2001 03:57:37 -0400
Received: from t2.redhat.com ([199.183.24.243]:60915 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135770AbRDTH5V>; Fri, 20 Apr 2001 03:57:21 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <B7054D66.424B%jeff.galloway@rundog.com> 
In-Reply-To: <B7054D66.424B%jeff.galloway@rundog.com> 
To: Jeff Galloway <jeff.galloway@rundog.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3 Compile Errors - Power Mac 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Date: Fri, 20 Apr 2001 08:57:18 +0100
Message-ID: <13993.987753438@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



jeff.galloway@rundog.com said:
>   However, I don't think that wishing the world would avoid these
> dominant (and very useful) formats is a realistic expectation.  It is
> certainly not "common sense" to assume as such.

Of course it's not a realistic expectation. There are times when it's a pain
to have to be safe - people will always break the rules when they're in a
hurry and the document to be sent is already in an unsafe format. But taking
plain text with absolutely no formatting, in fact text which is
_degenerated_ by word wrapping &c, and gratuitously putting it in a Word
document is just _so_ unnecessary that I assumed it had to be a troll.


> fork.c: In function Œcopy_mm¹:

Given what this output's been through - I'll assume it's corrupted in 
transit, shall I? 

The kind of error you're seeing is often caused by a mismatch between 
compiler and kernel. As Alan suggests, you should make sure you're using a 
PPC-specific tree because it's not up to date in the stock 2.4.3. And make 
sure you're using the recommended versions of compiler and binutils. Other 
than that, I'm afraid I don't know.

--
dwmw2


