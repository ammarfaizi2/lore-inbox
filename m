Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264754AbUDWIOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264754AbUDWIOa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 04:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264756AbUDWIOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 04:14:30 -0400
Received: from cpc3-oxfd2-6-0-cust100.oxfd.cable.ntl.com ([81.103.193.100]:48136
	"EHLO fluffy.bear-cave.org.uk") by vger.kernel.org with ESMTP
	id S264754AbUDWIO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 04:14:29 -0400
Message-ID: <XFMail.20040423091422.jim.hague@acm.org>
X-Mailer: XFMail 1.5.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
In-Reply-To: <40887BE3.9080502@trash.net>
Date: Fri, 23 Apr 2004 09:14:22 +0100 (BST)
X-Face: #e_3/{lz7I8PY]c%cr|7\sfMTD|Ar*F0e~U%InA`aG0^}hG2hT`H9Lr=R?Nl,9-cP)_o}BN
 DAB"m_&V"ntfjv%6q30^]Q\<YL5[mLMi"X_qm`eA^AA?-SC>NTny77`@0?P@FpO{b*dM409XvO$kmP
 [~W=-Cm~|#49QE;@'K}LGK}??aD=>|x=B:n6"`}!9FIrtfOx%`hTC5#VFORluPrtN_#-_6b,Cu^NF|
 :D=97AFz\(mw=K
Organization: The Bear Cave
From: Jim Hague <jim.hague@acm.org>
To: Patrick McHardy <kaber@trash.net>
Subject: Re: [PATCH]: Fix NULL-ptr dereference in pm2fb_probe
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-Apr-2004 Patrick McHardy wrote:
> This patch fixes a NULL-pointer dereference in pm2fb_probe.
> The memset sets info->par to 0, it is dereferenced shortly
> afterwards. framebuffer_alloc already initializes the memory
> to 0, so it can simply be removed.

Thanks for your work. We've overlapped on this one, I'm afraid - a couple of
days ago I sent a patch off to James and the fbdev list that addresses this and
a bug in pm2fb_blank().

Out of interest, can I ask if you're running pm2fb and if so on what hardware?

-- 
Jim Hague - jim.hague@acm.org          Never trust a computer you can't lift.
