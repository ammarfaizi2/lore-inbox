Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWE3Nyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWE3Nyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 09:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWE3Nyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 09:54:47 -0400
Received: from boogie.lpds.sztaki.hu ([193.225.12.226]:10985 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S932180AbWE3Nyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 09:54:46 -0400
Date: Tue, 30 May 2006 15:54:44 +0200
From: Gabor Gombas <gombasg@sztaki.hu>
To: Bernd Eckenfels <be-news06@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain
Message-ID: <20060530135444.GA10831@boogie.lpds.sztaki.hu>
References: <20060529122536.GE22245@boogie.lpds.sztaki.hu> <E1Fkqvn-0001ts-00@calista.eckenfels.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Fkqvn-0001ts-00@calista.eckenfels.net>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 01:13:51AM +0200, Bernd Eckenfels wrote:

> There are some (common) applications which bind more meaning to that string.
> Most noteable MTAs if they are configured to detect things automatically.

MTAs and most other sensible daemons have configuration options for
overriding the host name exactly because the heuristic of "try to use
gethostname() and hope that it is resolvable" does not work in many
cases.

Using the hostname by default is fine if you keep in mind that it is
only a heuristic and that it is not guaranteed to work.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
