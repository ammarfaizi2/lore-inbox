Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbUKORWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbUKORWw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 12:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbUKORWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 12:22:52 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:53329 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261335AbUKORWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 12:22:51 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] uml: fail xterm_open when we have no $DISPLAY
Date: Mon, 15 Nov 2004 18:24:29 +0100
User-Agent: KMail/1.7.1
Cc: Chris Wedgwood <cw@f00f.org>, Jeff Dike <jdike@addtoit.com>,
       LKML <linux-kernel@vger.kernel.org>
References: <20041115032541.GA13077@taniwha.stupidest.org>
In-Reply-To: <20041115032541.GA13077@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411151824.29365.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 November 2004 04:25, Chris Wedgwood wrote:
> If UML wants to open an xterm channel and the xterm does not run
> properly (eg. terminates soon after starting) we will get a hang.
> This avoids the most common cause for this and adds a comment (which
> long term will go away with a rewrite of that code I guess?)

Thanks for drawing attention on this! I hadn't had the time to dig this out... 
for now reasonably correct, but no time to review it properly now. The review 
would probably try to find a more direct fix to this...
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
