Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUG0Jay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUG0Jay (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 05:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUG0J3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 05:29:16 -0400
Received: from main.gmane.org ([80.91.224.249]:60544 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261252AbUG0J2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 05:28:21 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: The dreadful CLOSE_WAIT
Date: Tue, 27 Jul 2004 11:28:17 +0200
Message-ID: <yw1xllh5ol3i.fsf@kth.se>
References: <20040727083947.GB31766@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:6mZGjm9mIn8RLcPtYKDSdpw7VGE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD <raul@pleyades.net> writes:

>     Hi all :))
>
>     Seems under Linux that, when a connection is in the CLOSE_WAIT
> state, the only wait to go to LAST_ACK is the application doing the
> 'shutdown()' or 'close()'. Doesn't seem to be a timeout for that.

Is that why some programs seem to hang forever when my NAT gateway
decides to drop a connection?

-- 
Måns Rullgård
mru@kth.se

