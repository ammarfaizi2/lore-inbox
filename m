Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315539AbSEQM3L>; Fri, 17 May 2002 08:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSEQM1x>; Fri, 17 May 2002 08:27:53 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44298 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315480AbSEQM0f>; Fri, 17 May 2002 08:26:35 -0400
Subject: Re: [PATCH] Page replacement documentation
To: mel@csn.ul.ie (Mel)
Date: Fri, 17 May 2002 13:46:37 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205170442260.29254-100000@skynet> from "Mel" at May 17, 2002 04:48:20 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178h81-0006OV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +     ----------------------------------------------------------------------
> +
> +     This document was translated from LATEX by HEVEA.

If you switched it into DocBook format then the kernel shipped tools
will generate a document from it including html/pdf/ps etc as well as
being able to embed stuff

> +/*
> + * shink_cache - Shrinks buffer caches in a zone
> + * nr_pages: Helps determine if process information needs to be sweapped

You've not tested these. They should start

/**
 *  ....


thats how it knows how to pick out that comment using kernel-doc. You 
can run scripts/kernel-doc over just one file if you want to check
it without all the docbook tools
