Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262332AbSI1U74>; Sat, 28 Sep 2002 16:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262333AbSI1U7z>; Sat, 28 Sep 2002 16:59:55 -0400
Received: from isis.cs3-inc.com ([207.224.119.73]:42998 "EHLO isis.cs3-inc.com")
	by vger.kernel.org with ESMTP id <S262332AbSI1U7y>;
	Sat, 28 Sep 2002 16:59:54 -0400
From: don-temp5298413@isis.cs3-inc.com (Don Cohen)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15766.6531.690970.951007@isis.cs3-inc.com>
Date: Sat, 28 Sep 2002 14:05:07 -0700
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reading /proc files larger than one buffer
In-Reply-To: <3D9611A0.3080905@pobox.com>
References: <200209282010.g8SKASL01208@isis.cs3-inc.com>
	<3D9611A0.3080905@pobox.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > There is a new seq_xxx API that covers this quite well... the 

Where can I find code or doc for this?

 > documentation should be updated to include that, especially.  seq_xxx 
 > should take care of a large number of complex or potentially-large 
 > procfs output.
 > 
 > Any change you would be interested in updating the docs?  ;-)
(you mean chance?)

I'd prefer to have the code updated so the current doc is correct.
However, if updating doc is much easier or faster then I suggest
adding that one line as something else you should do in your read
function.  
BTW there were other things I found confusing about that doc, and I'd
be happy to suggest other improvements to someone who can make them.
Wouldn't it be better, though, for the people who write the code to
write doc instead of someone like me who is only trying to hallucinate
intent from the code?  I'd be much happier to review doc written by
the author of the code.
