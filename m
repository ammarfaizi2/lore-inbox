Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288978AbSAITse>; Wed, 9 Jan 2002 14:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288979AbSAITs1>; Wed, 9 Jan 2002 14:48:27 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:4759
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288978AbSAITsP>; Wed, 9 Jan 2002 14:48:15 -0500
Message-Id: <200201091932.g09JW9A27178@snark.thyrsus.com>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@zip.com.au (Andrew Morton)
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Wed, 9 Jan 2002 06:44:52 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16OM59-0001hQ-00@the-village.bc.nu>
In-Reply-To: <E16OM59-0001hQ-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 January 2002 12:00 pm, Alan Cox wrote:
> > The high-end audio synth guys claim that two milliseconds is getting
> > to be too much.  They are generating real-time audio and they do
> > have more than one round-trip through the software.  It adds up.
>
> Most of the stuff I've seen from high end audio people consists of
> overthreaded, chains of code written without any consideration for the
> actual cost of execution. There are exceptions - including
> people dynamically compiling filters to get ideal cache and latency
> behaviour, but not enough.
>
> Alan

News flash: people are writing sub-optimal apps in user space.

Do you want an operating system capable of running real-world code written by 
people who know more about their specific problem domain (audio) than about 
optimal coding in general, or do you want an operating system intended to 
only run well-behaved applications designed and implemented by experts?

Rob
