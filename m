Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310232AbSCEVRv>; Tue, 5 Mar 2002 16:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293725AbSCEVRl>; Tue, 5 Mar 2002 16:17:41 -0500
Received: from AMontpellier-201-1-1-61.abo.wanadoo.fr ([193.252.31.61]:22544
	"EHLO awak") by vger.kernel.org with ESMTP id <S292891AbSCEVRh> convert rfc822-to-8bit;
	Tue, 5 Mar 2002 16:17:37 -0500
Subject: Re: Monolithic Vs. Microkernel
From: Xavier Bestel <xavier.bestel@free.fr>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Pavel Machek <pavel@suse.cz>, Rakesh Kumar Banka <Rakesh@asu.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L.0203051803120.1413-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.44L.0203051803120.1413-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 05 Mar 2002 22:17:11 +0100
Message-Id: <1015363031.9958.3.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le mar 05-03-2002 à 22:04, Rik van Riel a écrit :
> On Mon, 4 Mar 2002, Pavel Machek wrote:
> 
> > > This means we can have all the advantages of modularity at the
> >
> > Not *all* of them. On vsta, you could do
> >
> > ( killall keyboard; sleep 1; keyboard ) &
> 
> How is that different from the following ?
> 
> (rmmod keyboard ; sleep 1 ; modprobe keyboard)
> 
> [no, no need to talk about hardware access ... vsta's keyboard
> driver also has hardware access]

killall works when keyboard is deadlocked, I suppose.


