Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315300AbSEVW2E>; Wed, 22 May 2002 18:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSEVW2E>; Wed, 22 May 2002 18:28:04 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18697 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315300AbSEVW2C>; Wed, 22 May 2002 18:28:02 -0400
Subject: Re: PATCH Multithreaded core dumps for the 2.5.17 kernel  was ....RE:    PATCH Multithreaded core dump support for the 2.5.14 (aO
To: mgross@unix-os.sc.intel.com
Date: Wed, 22 May 2002 23:07:24 +0100 (BST)
Cc: pavel@suse.cz (Pavel Machek), vamsi_krishna@in.ibm.com (Vamsi Krishna S.),
        mark.gross@intel.com (Gross Mark), linux-kernel@vger.kernel.org,
        r1vamsi@in.ibm.com
In-Reply-To: <200205222043.g4MKhsw06808@unix-os.sc.intel.com> from "Mark Gross" at May 22, 2002 01:43:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AeGS-0002wv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think that although my tcore_suspend_threads and Pavel's freeze_processes 
> have similar results, I don't think using Pavel's approach for the core dump 
> is a good idea.

Migrating a task to a specific processor is also remarkably related. How does
it wash out if the suspend thread/freeze process stuff works by migrating
all the processes to a CPU that doesnt exist ?
