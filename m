Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbUDHHLB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 03:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUDHHLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 03:11:01 -0400
Received: from ATuileries-102-2-1-196.w193-251.abo.wanadoo.fr ([193.251.178.196]:41948
	"EHLO kaluha.idtect.net") by vger.kernel.org with ESMTP
	id S261996AbUDHHK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 03:10:57 -0400
In-Reply-To: <1081370270.2557.16320.camel@localhost>
References: <22D3DBAA-7833-11D8-97E9-000A95CFFC9C@idtect.com> <1081370270.2557.16320.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E0778696-892B-11D8-897C-000A95CFFC9C@idtect.com>
Content-Transfer-Encoding: 7bit
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From: Charles-Edouard Ruault <ce@idtect.com>
Subject: Re: [NFS] Linux 2.4.25, nfs client hangs when talking to a MacOS nfs server.
Date: Thu, 8 Apr 2004 09:10:54 +0200
To: Chris Worley <cworley@lnxi.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 7, 2004, at 10:37 PM, Chris Worley wrote:

> I have a similar problem when there's an MTU mismatch between client 
> and
> server (i.e. the server is 9K and the client is 1400 bytes)... although
> other TCP and UDP connections don't have a problem, NFS does.
>
> The solutions are, on the client side: 1) use TCP instead of UDP for
> NFS, or 2) set the rsize/wsize below 1400 bytes.
>
>
Hi Chris,
thanks for the reply.
My problem does not seem related to MTU mismatch since both sides have 
an MTU of 1500.
I've been able to solve the problem by using TCP has some other people 
have suggested.
 From what i understant it was due to the lack of flow control of UDP....


Charles-Edouard Ruault
Idtect SA
tel: +33-1-42-81-81-84
fax: +33-1-42-81-82-21
http://www.idtect.com

