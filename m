Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278479AbRJPA5J>; Mon, 15 Oct 2001 20:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278484AbRJPA47>; Mon, 15 Oct 2001 20:56:59 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:16671 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S278479AbRJPA4t>;
	Mon, 15 Oct 2001 20:56:49 -0400
Message-ID: <20011016025742.A10992@win.tue.nl>
Date: Tue, 16 Oct 2001 02:57:42 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: "David S." <davids@idiom.com>, linux-kernel@vger.kernel.org
Subject: Re: Anomalous results from access(2)
In-Reply-To: <20011015151809.D372@malign.rad.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20011015151809.D372@malign.rad.washington.edu>; from David S. on Mon, Oct 15, 2001 at 03:18:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2001 at 03:18:09PM -0700, David S. wrote:

> [1.]	Anomalous results from access(2)
> 
> [2.]	When by root run against files in the ext2 file system, access(2)
> 	reports non-executable files as executable.  For a non-privileged
> 	user, access(2) reports non-executable files as non-executable.

All is entirely according to specs.  I added the sentence

       If  the process has appropriate privileges, an implementa-
       tion may indicate success for X_OK even  if  none  of  the
       execute file permission bits are set.

to access.2.

