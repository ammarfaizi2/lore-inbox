Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285161AbSALJAe>; Sat, 12 Jan 2002 04:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285338AbSALJAY>; Sat, 12 Jan 2002 04:00:24 -0500
Received: from web20501.mail.yahoo.com ([216.136.226.136]:1577 "HELO
	web20501.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S285161AbSALJAS>; Sat, 12 Jan 2002 04:00:18 -0500
Message-ID: <20020112090017.87174.qmail@web20501.mail.yahoo.com>
Date: Sat, 12 Jan 2002 10:00:17 +0100 (CET)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200201111845.g0BIjS2318104@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Gee, when was the last time Intel removed something
> from the instruction set? An old 80286 instruction
> comes to mind, but that was a super-CISC mess that
> was really specific to the implementation. Anything
> really useful that was ever removed?

well, the 8088/8086 supported the POP CS instruction
which was used by a virus and 80186/80286 broke this
virus (which was rewritten anyway).

The undocumented loadall instruction changes from
CPU to CPU, and the IBTS/XBTS bit string manipulation
instructions appeared in Step A 386 and disappeared
later. The Step A 486 reused their opcodes for CMPXCHG
and it changed just after in Step B.

This are very rare cases, but at least some
developpers could have based their work on the
existence of IBTS/XBTS but it disappeared.

Anyway, I cannot imagine that they could break
compatibility by removing CMOV !

Regards,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Courrier : http://courrier.yahoo.fr
