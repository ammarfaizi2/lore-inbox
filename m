Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264676AbSJTXpE>; Sun, 20 Oct 2002 19:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264674AbSJTXpE>; Sun, 20 Oct 2002 19:45:04 -0400
Received: from smtp08.iddeo.es ([62.81.186.18]:8616 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S264676AbSJTXpD>;
	Sun, 20 Oct 2002 19:45:03 -0400
Date: Mon, 21 Oct 2002 01:51:07 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: thunder7@xs4all.nl
Cc: Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Any hope of fixing shutdown power off for SMP?
Message-ID: <20021020235107.GA14334@werewolf.able.es>
References: <Pine.LNX.3.96.1021019152828.29078L-100000@gatekeeper.tmr.com> <20021020053702.GA3579@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021020053702.GA3579@middle.of.nowhere>; from thunder7@xs4all.nl on Sun, Oct 20, 2002 at 07:37:02 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.10.20 Jurriaan wrote:
>From: Bill Davidsen <davidsen@tmr.com>
>Date: Sat, Oct 19, 2002 at 03:40:22PM -0400
>> I've beaten this dead horse before, but it still irks me that Linux can't
>> power down an SMP system. People claim that it can't be done safely, but
>> maybe somone can reverse engineer NT if we aren't up to the job.
>> 
>I'm trying to find out the same. So far:
>

There are patches both in the -ac and -aa tree to make smp kernels shut
down properly, even to support full APM if you have enough luck. shutdown
works fine on my smp box...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-pre11-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
