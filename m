Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266053AbRF1R2p>; Thu, 28 Jun 2001 13:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266047AbRF1R2j>; Thu, 28 Jun 2001 13:28:39 -0400
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:5514 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S266050AbRF1R2W>; Thu, 28 Jun 2001 13:28:22 -0400
Date: Thu, 28 Jun 2001 19:28:20 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: Pekka Pietikainen <pp@evil.netppl.fi>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux and system area networks
In-Reply-To: <20010627154140.A14908@netppl.fi>
Message-ID: <Pine.LNX.4.33.0106281918560.32296-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2001, Pekka Pietikainen wrote:

> Providing a wrapper library for use with Infiniband and the current
> SAN boards like WSD would probably be a useful exercise, but to really get
> good performance (especially latency-wise) you probably want to use
> something like MPI. For many applications a wrapper will be enough, though.

I'm sorry, but I don't understand your reference to MPI here. MPI is a
high-level API; MPI can run on top of whatever communication features
exists: TCP/IP, shared memory, VI, etc.
MPI (as well as other "standards" for parallel programming - PVM, OpenMP)
came from the need to have a common interface, not to have all parallel
programs include specific code to deal with TCP/IP, shared memory, VI,
etc. whenever they were available. Instead, MPI serves as a middle-man
between them and the parallel programs. So, MPI cannot be faster than the
underlying communication features.

Sincerely,

Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De


