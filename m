Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270721AbRHKErT>; Sat, 11 Aug 2001 00:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270722AbRHKErJ>; Sat, 11 Aug 2001 00:47:09 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:55055 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S270721AbRHKErF>;
	Sat, 11 Aug 2001 00:47:05 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200108110447.f7B4l9Y439730@saturn.cs.uml.edu>
Subject: Re: re-export nfs possible?
To: nbecker@fred.net
Date: Sat, 11 Aug 2001 00:47:09 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3wv4nmei0.fsf@nbecker.fred.net> from "nbecker@fred.net" at Aug 01, 2001 09:34:15 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nbecker@fred.net writes:

> Is it possible to mount a fs via nfs, and then reexport it via nfs?

Currently, no.

With some restrictions, it could be done. For any given IP address,
you could export or re-export filesystems from _one_ source server.
Anything more is like trying to cram N+1 bits into an N-bit sack,
and no you can't assume the bits are compressible.

