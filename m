Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUFTIin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUFTIin (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 04:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265509AbUFTIin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 04:38:43 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:65155 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S263769AbUFTIim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 04:38:42 -0400
Subject: Re: [PATCH] Stop printk printing non-printable chars
From: David Woodhouse <dwmw2@infradead.org>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       jbglaw@lug-owl.de, arjanv@redhat.com,
       Linus Torvalds <torvalds@osdl.org>, matthew-lkml@newtoncomputing.co.uk
In-Reply-To: <1087704177.8185.951.camel@cube>
References: <1087704177.8185.951.camel@cube>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1087720713.4520.13.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sun, 20 Jun 2004 09:38:33 +0100
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-20 at 00:02 -0400, Albert Cahalan wrote:
> The 0x9b character must be blocked, 

Why do you say 'must be blocked' instead of 'should not be printed'?

The former implies some kind of post-processing to work around buggy
kernel code printing crap. Surely it's better just to refrain from
printing the crap in the first place?

Btw, your replies lack a correct References: and In-Reply-To: header, in
violation of a 'SHOULD' in RFC2822 §3.6.4. Please fix this if you wish
to participate in public fora.

-- 
dwmw2


