Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbSANPDu>; Mon, 14 Jan 2002 10:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284970AbSANPDj>; Mon, 14 Jan 2002 10:03:39 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:50412 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284933AbSANPD3>; Mon, 14 Jan 2002 10:03:29 -0500
Message-ID: <3C42F33C.88F423F6@redhat.com>
Date: Mon, 14 Jan 2002 15:03:24 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020114104532.59950d86.skraw@ithnet.com>; from skraw@ithnet.com on lun ene 14 2002 at 10:45:32 +0100 <20020114160256.A2922@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" wrote:
> 
> On 20020114 Stephan von Krawczynski wrote:
> >
> >Hm, obviously the ll-patches look simple, but their pure required number makes
> >me think they are as well stupid as simple. This whole story looks like making
> >an old mac do real multitasking, just spread around scheduling points
> 
> Yup. That remind me of...
> Would there be any kernel call every driver is doing just to hide there
> a conditional_schedule() so everyone does it even without knowledge of it ?
> Just like Apple put the SystemTask() inside GetNextEvent()...


Well the preempt patch sort of does this in every spin_unlock*() .....
