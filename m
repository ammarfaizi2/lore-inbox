Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263800AbUEHRUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbUEHRUc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 13:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbUEHRUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 13:20:32 -0400
Received: from main.gmane.org ([80.91.224.249]:38362 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263800AbUEHRUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 13:20:30 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: sean <seandarcy@hotmail.com>
Subject: Re: can't see drive on promise 20375 ATA card
Date: Sat, 08 May 2004 13:20:24 -0400
Message-ID: <c7j4sp$k85$1@sea.gmane.org>
References: <c7hgrq$5bv$1@sea.gmane.org> <c7ivot$a26$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ool-4356fe48.dyn.optonline.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a) Gecko/20040501
X-Accept-Language: en-us, en
In-Reply-To: <c7ivot$a26$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at the source - usually foolhardy at least for me, I find this 
at lines 1806-1808 of sata_promise.c:

               case board_2037x:
        		probe_ent->n_ports = 2;
		break;

Is the solution here as simple as changing two to three? Does this break 
somethng else?

Has anyone else got this board to work? It's been out over a year.

sean

