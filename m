Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129707AbQLBQnK>; Sat, 2 Dec 2000 11:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129872AbQLBQnA>; Sat, 2 Dec 2000 11:43:00 -0500
Received: from [66.30.136.189] ([66.30.136.189]:25610 "HELO
	kullstam.ne.mediaone.net") by vger.kernel.org with SMTP
	id <S129707AbQLBQm5>; Sat, 2 Dec 2000 11:42:57 -0500
From: "Johan Kullstam" <kullstam@ne.mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: multiprocessor kernel problem
In-Reply-To: <3A27D871.6CE7638B@lanl.gov>
Organization: none
Date: 02 Dec 2000 11:15:03 -0500
In-Reply-To: Roger Crandell's message of "Fri, 01 Dec 2000 09:57:21 -0700"
Message-ID: <m2u28m4x6g.fsf@euler.axel.nom>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Crandell <rwc@lanl.gov> writes:

> I should have mentioned this is a 4 processor machine with a 64 bit
> buss.

perhaps the netfilter stuff isn't 4-way SMP safe.  my quad ppro box
seizes with iptables too.  however, many people report it working with
2-way SMP boxen.

has anyone gotten netfilter/iptables to work on a SMP box with more
than 2 processors?

i recall old 2.0.x kernels deadlocking on a 4-way
until x=35 or so.  maybe this is somehow similar.

-- 
J o h a n  K u l l s t a m
[kullstam@ne.mediaone.net]
Don't Fear the Penguin!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
