Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314290AbSE0F2O>; Mon, 27 May 2002 01:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314285AbSE0F2N>; Mon, 27 May 2002 01:28:13 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:51596 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S314281AbSE0F2M> convert rfc822-to-8bit;
	Mon, 27 May 2002 01:28:12 -0400
Date: Mon, 27 May 2002 01:28:13 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: Robert Schwebel <robert@schwebel.de>
Cc: Larry McVoy <lm@bitmover.com>, <linux-kernel@vger.kernel.org>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <20020526011620.C598@schwebel.de>
Message-ID: <Pine.LNX.4.33L2.0205270125220.24180-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Robert
> ¹ There are surely small things which cannot be implemented in
>   another way - try to write a counting loop in another way than
>   for (i=0; i<N; i++) {printf(i);}
>

void loopie(int N)
{
	if (N) loopie(N-1);
	printf("%d ",N);
}

