Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264443AbRFTQ5Z>; Wed, 20 Jun 2001 12:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264454AbRFTQ5P>; Wed, 20 Jun 2001 12:57:15 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:21126 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S264443AbRFTQ5J>; Wed, 20 Jun 2001 12:57:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Mike Porter <mike@UDel.Edu>, bert hubert <ahu@ds9a.nl>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Date: Wed, 20 Jun 2001 07:56:10 -0400
X-Mailer: KMail [version 1.2]
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.31.0106201027220.17484-100000@copland.udel.edu>
In-Reply-To: <Pine.SOL.4.31.0106201027220.17484-100000@copland.udel.edu>
MIME-Version: 1.0
Message-Id: <01062007561003.00776@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 June 2001 10:35, Mike Porter wrote:
> > But that foregoes the point that the code is far more complex and harder
> > to make 'obviously correct', a concept that *does* translate well to
> > userspace.
>
> One point is that 'obviously correct' is much harder to 'prove' for
> threads (or processes with shared memory) than you might think.
> With a state machine, you can 'prove' that object accesses won't
> conflict much more easily.  With a threaded or process based model,
> you have to spend considerable time thinking about multiple readers
> and writers and locking.
>
> One metric I use to evaluate program complexity is how big of a
> headache I get when trying to prove something "correct".
> Multi-process or multi-threaded code hurts more than a well written
> state machine.

The same applies to security though.  There's programmers out there we're 
unwilling to give the tools to create race conditions, but we expect them to 
write stuff that won't allow a box on the internet to be own3d in under 24 
hours...

Obvious isn't always correct...

Rob
