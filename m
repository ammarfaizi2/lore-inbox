Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272074AbTGYNzz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 09:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272075AbTGYNzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 09:55:55 -0400
Received: from www.13thfloor.at ([212.16.59.250]:60805 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S272074AbTGYNzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 09:55:53 -0400
Date: Fri, 25 Jul 2003 16:11:12 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: ulimit behaviour ...
Message-ID: <20030725141112.GA2713@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All!

Just stumbled over it ...

ulimit -H -u <#procs>

refuses to go below the current 'soft' limit,
this was not the case in 2.4.21, but I do not
know when, how and why this changed ...

I do not have a problem with that, but it will
give some troubles on certain configurations,
which simply reduce the hard limit to something
reasonable and expect the soft limit to follow

best,
Herbert

