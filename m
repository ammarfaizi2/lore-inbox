Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311594AbSCaE14>; Sat, 30 Mar 2002 23:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311600AbSCaE1p>; Sat, 30 Mar 2002 23:27:45 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:55690 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S311594AbSCaE1i>; Sat, 30 Mar 2002 23:27:38 -0500
Message-ID: <3CA6819F.3090007@wanadoo.fr>
Date: Sun, 31 Mar 2002 05:25:19 +0200
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Murphy <tim@birdsnest.maths.tcd.ie>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.7
In-Reply-To: <20020330232307.A2673@birdsnest.maths.tcd.ie>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Murphy wrote:
> I'm sure this has been recognised,
> but I would point out that sys_nfsservctl is not "undefined"
> if NFSD is not chosen.

I've noticed 2.5.7 fails to build without tcp/ip enabled :
sock.c:559: `TCP_LISTEN' undeclared
sock.c:1192: `TCP_CLOSE' undeclared
*and* without nfs choosen for the reason you give.

Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

