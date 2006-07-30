Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWG3LbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWG3LbQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 07:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWG3LbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 07:31:15 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:54368 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932269AbWG3LbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 07:31:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=QJyppndoVrSWXAC9ZritpxksuM6TPqy+tHO5k0LTFUBV+kG5tPHCYCJaJyw30n2ZRJfLXF+nqjtPOwsJdkmWpyORRD73iizp2LrqJ+C8lTqrPy64c5FDVKhjYBiM+P+r5EZMzuF1p1LZyq1gZL5tbZOPegu6kPMQJhobhYZ/Wlw=
Message-ID: <44CC9885.8030506@gmail.com>
Date: Sun, 30 Jul 2006 13:30:54 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FP in kernelspace
References: <44CC97A4.8050207@gmail.com>
In-Reply-To: <44CC97A4.8050207@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Hello,
> 
> I have a driver written for 2.4 + RT patches with FP support. I want it 
> to work in 2.6. How to implement FP? Has anybody developped some 
> "protocol" between KS and US yet? If not, could somebody point me, how 
> to do it the best -- with low latency.
One more thing, it can't be table-precomputed, positions are read from the 
device, needs to be recomputed and pushed back.

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
