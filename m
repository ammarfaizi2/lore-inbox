Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130425AbRCGHsZ>; Wed, 7 Mar 2001 02:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130428AbRCGHsP>; Wed, 7 Mar 2001 02:48:15 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:9738 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S130425AbRCGHsI>; Wed, 7 Mar 2001 02:48:08 -0500
Date: Wed, 7 Mar 2001 03:02:14 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Alexander Viro <viro@math.psu.edu>
Cc: Jeremy Elson <jelson@circlemud.org>, linux-kernel@vger.kernel.org
Subject: Re: Mapping a piece of one process' addrspace to another?
In-Reply-To: <Pine.GSO.4.21.0103070051060.2127-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0103070301310.1548-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Mar 2001, Alexander Viro wrote:

> 
> 
> You are reinventing the wheel.
> man ptrace (see PTRACE_{PEEK,POKE}{TEXT,DATA} and PTRACE_{ATTACH,CONT,DETACH})

With ptrace data will be copied twice. As far as I understood, Jeremy
wants to avoid that. 

