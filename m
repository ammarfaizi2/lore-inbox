Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284200AbRLLADF>; Tue, 11 Dec 2001 19:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284248AbRLLAC4>; Tue, 11 Dec 2001 19:02:56 -0500
Received: from air-1.osdl.org ([65.201.151.5]:24590 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S284200AbRLLACp>;
	Tue, 11 Dec 2001 19:02:45 -0500
Date: Tue, 11 Dec 2001 15:57:53 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: porting howto for 2.5?
In-Reply-To: <200112082126.WAA10376@nbd.it.uc3m.es>
Message-ID: <Pine.LNX.4.33L2.0112111556000.4033-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Dec 2001, Peter T. Breuer wrote:

| OK, I'm beat for the night.
|
|    io_request_lock disappeared. OK, so apparently I'm now supposed
|    to use the queue lock.
|
|    req->cmd is now an array. OK, so I really wanted the direction of
|    the req, so I used rq_data_dir, which looks at the req->flags.
|    But what are the flags for? I need space on a req to hold a
|    "sequence number". Doesn't matter if it wraps. Just has to be
|    valid for 10s. What is the cmd array an array OF?
|
|    buffer heads have gone! Now there are "bio"s. Boo hoo .. just
|    when I was really getting good with buffer_head. How do I
|    copy stuff to/from user space from a bio!? It seems to contain
|    bio_vecs.
|
| Is there a 2.4-2.5 porting howto beginning to be developed somewhere?
| Please?
|
| How can one man do such damage in just one version increment :-)?

Indeed.  8;}

For a start, see "http://www.osdl.org/archive/rddunlap/linux-port-25x.html".

If anyone has additions, corrections, comments, etc., please
send them.

-- 
~Randy

