Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266675AbUFWVHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266675AbUFWVHf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUFWVHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:07:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45208 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266675AbUFWVGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:06:30 -0400
Date: Wed, 23 Jun 2004 14:06:28 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Alphabet of kernel source
Message-Id: <20040623140628.3f1abfe9@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

I have a silly question, for which I am unable to google out the answer
so far. Do we have a Linus' decree on the charset and encoding of the
kernel source?

I had a funny situation recently... I prefer non-MIME attachements
for two reasons: a) I grab parts of the header and fold them into
patch and b) it is easier to quote fragments of the patch with clients
I tried (mutt and sylpheed). Admittendly, a different MUA software may
change these habits, but please bear with me here. So, someone sent
me a patch which included a context line with MODULE_AUTHOR() with
an accented name, which the author entered in ISO-8859-1 (he was German).
I replied, but my mail agent recoded the reply as UTF-8. The author
agreed to my patch, and copied my reply, sent to me. Everything was
perfectly readable at this point, but the patch rejected. Because
I use Russian and Japanese simultaneously, all utilities run with UTF-8
my boxes, so it took me a moment to do "LANG=C vi" and find the problem.

Anyhow, long story short, this got me thinking... What is the charset
and the encoding of the actual source? I saw quite a discussion about
the filenames, but this is different. I am sorry if this was discussed
previously.

-- Pete
