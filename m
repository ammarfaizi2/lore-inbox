Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbUJaJN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbUJaJN6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 04:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbUJaJN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 04:13:58 -0500
Received: from quechua.inka.de ([193.197.184.2]:31188 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261444AbUJaJN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 04:13:57 -0500
Date: Sun, 31 Oct 2004 10:13:55 +0100
From: Bernd Eckenfels <be-mail2004@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: LVM Oops
Message-ID: <20041031091355.GA27407@lina.inka.de>
References: <418428C6.7070707@staff.theuseful.com> <E1CO4dR-0004ZN-00@calista.eckenfels.6bone.ka-ip.net> <20041031022133.GA18294@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041031022133.GA18294@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 07:21:33PM -0700, Chris Wedgwood wrote:
> Which version of XFS and when?  The XFS block allocator uses more
> stack in low-memory conditions and would over-flow 4K stacks
> previously but Nathan made some changes which should make it better.

It was some 2.4 version, but the stacktrace was not related to XFS I think.
It was just that reproducible one got panic or oops (not sure) if the
snapshot volumne was full. Hevent tried that with 2.6 yet, will do.

Greetings
Bernd
-- 
  (OO)      -- Bernd_Eckenfels@Mörscher_Strasse_8.76185Karlsruhe.de --
 ( .. )      ecki@{inka.de,linux.de,debian.org}  http://www.eckes.org/
  o--o     1024D/E383CD7E  eckes@IRCNet  v:+497211603874  f:+497211606754
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
