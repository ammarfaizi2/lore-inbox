Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272373AbRIKKcL>; Tue, 11 Sep 2001 06:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272374AbRIKKcB>; Tue, 11 Sep 2001 06:32:01 -0400
Received: from motgate3.mot.com ([144.189.100.103]:9648 "EHLO motgate3.mot.com")
	by vger.kernel.org with ESMTP id <S272373AbRIKKbo>;
	Tue, 11 Sep 2001 06:31:44 -0400
Message-Id: <3B9DE81B.EA680E13@crm.mot.com>
Date: Tue, 11 Sep 2001 12:31:55 +0200
From: Emmanuel Varagnat <Emmanuel_Varagnat-AEV010@email.mot.com>
Reply-To: Emmanuel Varagnat-AEV010 
	  <Emmanuel_Varagnat-AEV010@email.mot.com>
Organization: Centre de Recherche de Motorola - Paris
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Cc: Raghava Raju <vraghava_raju@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel stack....
In-Reply-To: <20010910214741.19309.qmail@web20008.mail.yahoo.com> <20010910235725.C797@arthur.ubicom.tudelft.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Erik Mouw wrote:
> 
> I think you got a wrong understanding of the stack. The stack has no
> separate bss, data, and text sections, it's just a stack of function
> arguments, local variables, and return addresses.
> 
> Accessing the stack works automatically: call a function, and the
> function paramaters and the return address are pushed on the stack.

Yes but there is one stack per processor ?
And what about its maximum size ? Is it dynamical ?

-Manu
