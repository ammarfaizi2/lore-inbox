Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbUKSNZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbUKSNZn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 08:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbUKSNZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 08:25:42 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:44240
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S261403AbUKSNZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 08:25:38 -0500
Message-Id: <s19df451.058@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.3 Beta
Date: Fri, 19 Nov 2004 14:26:29 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: inline (and variants) function modifier
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

May I ask how one is supposed to write a non-static function and let the
compiler decide whether it is worth inlining? Since all of 'inline',
'__inline', and '__inline__' get __attribute__((always_inline))
attached, I can't see how I would currently do this. Wouldn't it make
sense to leave at least one of the three with its original meaning?

Additionally, while on a subject like this, is there a reason
attributes (as the above) are generally specified without leading (and
trailing) double underscores? This way, if I #define a symbol with the
name of an existing (or even future) attribute, things are going to
break, whereas conventions preclude me from #define-ing symbols with
double leading underscores.

Thank you,
Jan
