Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbTGFEtg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 00:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266606AbTGFEtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 00:49:36 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:1505 "HELO
	develer.com") by vger.kernel.org with SMTP id S266603AbTGFEtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 00:49:35 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer
To: linux-kernel@vger.kernel.org
Subject: C99 types VS Linus types
Date: Sun, 6 Jul 2003 07:03:58 +0200
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307060703.58533.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

before a standard was set, every single OS had to come up with its
own fancy fixed-size type definitions such as DWORD, ULONG, u32,
CARD32, u_int32_t and so on.

Since C99, the C language has acquired a standard set of machine
independent types that can be used for machine independent
fixed-width declarations.

Getting rid of all non-ISO types from kernel code could be a
desiderable long-term goal. Besides the inexplicable goodness
of standards compliance, my favourite argument is that not
depending on custom definitions makes copying code from/to
other projects a little easier.

Ok, "int32_t" is a little more typing than "s32_t", but in
exchange you get it syntax hilighted in vim like built-in
types ;-)

I suggest a soft approach: trying to use C99 types as much
as possible for new code and only converting old code to
C99 when it's not too much trouble.

I hope it doesn't turn into an endless flame war... This is
just a polite suggestion.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html

