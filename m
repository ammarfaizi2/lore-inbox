Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316855AbSGHMR5>; Mon, 8 Jul 2002 08:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316856AbSGHMR4>; Mon, 8 Jul 2002 08:17:56 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:49639 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S316855AbSGHMRy>; Mon, 8 Jul 2002 08:17:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Bernd Schubert <bernd-schubert@web.de>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is 'transname' still alive ?
Date: Mon, 8 Jul 2002 14:20:29 +0200
User-Agent: KMail/1.4.2
References: <20020706184855.GA8343@werewolf.able.es>
In-Reply-To: <20020706184855.GA8343@werewolf.able.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207081419.48301.bernd.schubert@tc.pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we also using ClusterNFS but also experience several UNFSD bugs. So we have 
decided to try to reimplement transname into 2.4.18. Actually reading the 
'translated'  filename already works, but writing and other functions are 
still a problem. 

So we are working on it, but since we don't have a lot of time, it might take 
a while until it is ready.

Btw, some help from people who are familiar with VFS is highly appreciated.


Bernd

PS: The CVS version from ClusterNFS has some problems with the CREATE-tag 
fixed (though for all files that have a create-tag but no client specific 
file, IO-errors appear; the fix for this is already ready since several 
months,  but I had to experience another bug, that made this fix useless).

Bernd Schubert
Physikalisch Chemisches Institut
Abt. Theoretische Chemie
INF 229, 69120 Heidelberg
Tel.: 06221/54-5210
e-mail: bernd (dot) schubert (at) pci (dot) uni (minus) heidelberg (dot) de

