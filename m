Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRDPTxH>; Mon, 16 Apr 2001 15:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132039AbRDPTw5>; Mon, 16 Apr 2001 15:52:57 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:25107 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129134AbRDPTwm>;
	Mon, 16 Apr 2001 15:52:42 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104161952.f3GJqWn07999@saturn.cs.uml.edu>
Subject: Re: [PATCH] Unisys pc keyboard new keys patch, kernel 2.4.3
To: dwguest@win.tue.nl (Guest section DW)
Date: Mon, 16 Apr 2001 15:52:32 -0400 (EDT)
Cc: ebiederm@xmission.com (Eric W. Biederman), hpa@zytor.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010416194147.A16559@win.tue.nl> from "Guest section DW" at Apr 16, 2001 07:41:47 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guest section DW writes:
> On Mon, Apr 16, 2001 at 12:29:11AM -0600, Eric W. Biederman wrote:

>> If we can try to keycodes in 8-bits it would be nice.  The difficulty
>> is that X cannot handle more than 8-bits without telling it you have
>> multiple keyboards.  The keycode (at least in X) is exported to
>> X applications.  This is certainly something to coordinate with the
>> XFree folks about.  If you really need more then 8-bits. 
>
> X keycodes are unrelated to Linux keycodes.

Yes, but they could be. Changing the Linux keycodes is a major
break with compatibility. If the Linux keycodes are to be changed,
then they ought to be become something that would allow XFree86
to become keyboard-independent. Why invent yet another encoding?

