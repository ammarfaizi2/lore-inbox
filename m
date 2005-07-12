Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVGLDMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVGLDMn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 23:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVGLDMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 23:12:38 -0400
Received: from opersys.com ([64.40.108.71]:26893 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261965AbVGLDJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 23:09:56 -0400
Message-ID: <42D3331F.8020705@opersys.com>
Date: Mon, 11 Jul 2005 23:03:59 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
References: <17107.6290.734560.231978@tut.ibm.com> <20050712030555.GA1487@kroah.com>
In-Reply-To: <20050712030555.GA1487@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH wrote:
> What ever happened to exporting the relayfs file ops, and just using
> debugfs as your controlling fs instead?  As all of the possible users
> fall under the "debug" type of kernel feature, it makes more sense to
> confine users to that fs, right?

Actually, like we discussed the last time this surfaced, there are far
more users for relayfs than just debugging. What we settled on was
having relayfs export its file ops so that indeed debugfs users could
use it to log things in conjunction with debugfs.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
