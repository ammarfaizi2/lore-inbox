Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289657AbSAOUbu>; Tue, 15 Jan 2002 15:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289646AbSAOUbl>; Tue, 15 Jan 2002 15:31:41 -0500
Received: from ua18d4hel.dial.kolumbus.fi ([62.248.131.18]:8274 "EHLO
	porkkala.jlaako.pp.fi") by vger.kernel.org with ESMTP
	id <S290270AbSAOUbZ>; Tue, 15 Jan 2002 15:31:25 -0500
Message-ID: <3C449140.889FC8A0@kolumbus.fi>
Date: Tue, 15 Jan 2002 22:29:52 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <200201150143.CAA24288@webserver.ithnet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
> 
> Time to take out these big hats and rename ourself to Gandalf or the
> like. What do you expect your server to do, having no problem "most of
> the time"? Please read Albert E. Time can be pretty relative to your
> personal point of view...

Is this flaming really necessary?

So we don't have care about how long some driver spends in it internal
loops? So we could as well start writing drivers like 

	while (!frame_received()) udelay(1000000);

Because one day we will have powershortage anyway and that will anyway cause
few hours latencypeak? And if the user pulls the ethernet plug we don't have
to do anything else?


 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

