Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130274AbRCGF4Z>; Wed, 7 Mar 2001 00:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130307AbRCGF4Q>; Wed, 7 Mar 2001 00:56:16 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:12733 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130274AbRCGF4F>;
	Wed, 7 Mar 2001 00:56:05 -0500
Date: Wed, 7 Mar 2001 00:55:28 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jeremy Elson <jelson@circlemud.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Mapping a piece of one process' addrspace to another?
In-Reply-To: <200103070519.f275JSw05855@servo.isi.edu>
Message-ID: <Pine.GSO.4.21.0103070051060.2127-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



You are reinventing the wheel.
man ptrace (see PTRACE_{PEEK,POKE}{TEXT,DATA} and PTRACE_{ATTACH,CONT,DETACH})

							Cheers,
								Al

