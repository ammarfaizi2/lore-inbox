Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314293AbSDRKeu>; Thu, 18 Apr 2002 06:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314294AbSDRKet>; Thu, 18 Apr 2002 06:34:49 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32013 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314293AbSDRKes>; Thu, 18 Apr 2002 06:34:48 -0400
Subject: Re: [RFC] 2.5.8 sort kernel tables
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Thu, 18 Apr 2002 11:52:50 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020418102105.GB7884@merlin.emma.line.org> from "Matthias Andree" at Apr 18, 2002 12:21:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16y9X0-0004LY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any real-world figures on how long this sort process would take on big
> tables on some sparc or i586 class box? (Just trying to figure if bubble
> is really adequate. It is if the table is indeed essentially sorted with
> only like 10 reversed neighbours or if it's short.)

If the table is 90% ordered an insertion sort searching from tail is even
more efficient for the general case and just as simple. Its still arguing
about milliseconds 8)
