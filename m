Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312053AbSCQP3e>; Sun, 17 Mar 2002 10:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312051AbSCQP3Y>; Sun, 17 Mar 2002 10:29:24 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:51685 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S312050AbSCQP3R>; Sun, 17 Mar 2002 10:29:17 -0500
Date: Sun, 17 Mar 2002 07:29:17 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Mike Galbraith <mikeg@wen-online.de>, Daniel Egger <degger@fhm.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] 7.52 second kernel compile
Message-ID: <808957549.1016350156@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.10.10203170915100.994-100000@mikeg.wen-online.de>
In-Reply-To: <Pine.LNX.4.10.10203170915100.994-100000@mikeg.wen-online.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes.  Last time I tested, -pipe was _always_ a loser, and writing to
> swap was measurably faster than writing to fs.

Yup, was a looser for me too. I have a vague random theory that
things get blocked on pipe writes, thus causing more context switches.
I have plans at some point to try the improved pipe stuff that 
Hubertus and others were working on, and see if that helps.

M.

