Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVBGDTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVBGDTt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 22:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVBGDTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 22:19:48 -0500
Received: from opersys.com ([64.40.108.71]:4101 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261299AbVBGDTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 22:19:47 -0500
Message-ID: <4206DD87.3010902@opersys.com>
Date: Sun, 06 Feb 2005 22:16:23 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Tom Zanussi <zanussi@us.ibm.com>
CC: Kingsley Cheung <kingsley@aurema.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] relayfs crash
References: <41EF4E74.2000304@opersys.com> <20050207030444.GF27268@aurema.com>
In-Reply-To: <20050207030444.GF27268@aurema.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kingsley Cheung wrote:
> To solve the problem I applied a patch similar to the one you posted
> back in July and it fixed the problem.  Could we consider putting this
> patch into relayfs? Its similar to the one posted in July 2004, except
> it also moves clear_readers() before INIT_WORK in relay_release (is
> that acceptable?).

Tom, correct me if I'm wrong but these fixes were integrated in the
first relayfs redux I sent to LKML a few weeks back, right?

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
