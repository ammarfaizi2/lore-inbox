Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131595AbRC0Vp1>; Tue, 27 Mar 2001 16:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131653AbRC0VpR>; Tue, 27 Mar 2001 16:45:17 -0500
Received: from d83b5259.dsl.flashcom.net ([216.59.82.89]:42370 "EHLO
	home.lameter.com") by vger.kernel.org with ESMTP id <S131595AbRC0VpF>;
	Tue, 27 Mar 2001 16:45:05 -0500
Date: Tue, 27 Mar 2001 13:44:22 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
To: Chris Mason <mason@suse.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS phenomenon with 2.4.2 ac24/ac12
In-Reply-To: <393460000.985720850@tiny>
Message-ID: <Pine.LNX.4.21.0103271343360.8479-100000@home.lameter.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001, Chris Mason wrote:
> On Tuesday, March 27, 2001 11:14:57 AM -0800 Christoph Lameter
> <christoph@lameter.com> wrote:
> I should have been more clear.  Everyt ime you mount the filesystem, a it
> prints the hash used.  This is probably recorded in your log files, either
> 'Using r5 hash to sort names' or 'Using tea hash to sort names'.  For any
> given filesystem, it should never switch from one to the other.
reiserfs: checking transaction log (device 03:06) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:05) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
Undo loss 199.183.24.194/2530 c2 l0 ss2/65535 p0
Undo partial loss 216.234.231.6/1936 c1 l1 ss2/65535 p1
Out of Memory: Killed process 408 (mysqld).
Out of Memory: Killed process 411 (mysqld).
Out of Memory: Killed process 412 (mysqld).
Out of Memory: Killed process 422 (mysqld).
Out of Memory: Killed process 524 (apache).
Out of Memory: Killed process 525 (apache).
Out of Memory: Killed process 527 (apache).
Out of Memory: Killed process 528 (apache).
Out of Memory: Killed process 529 (apache).
Out of Memory: Killed process 529 (apache).
Out of Memory: Killed process 647 (kdeinit).
Out of Memory: Killed process 647 (kdeinit).
Out of Memory: Killed process 1485 (kdevelop).
Out of Memory: Killed process 643 (kdeinit).
Out of Memory: Killed process 652 (kdeinit).
Out of Memory: Killed process 650 (kdeinit).
Out of Memory: Killed process 650 (kdeinit).
Out of Memory: Killed process 650 (kdeinit).
Out of Memory: Killed process 636 (kdeinit).
Out of Memory: Killed process 639 (kdeinit).
Out of Memory: Killed process 5310 (find).
Undo partial loss 216.234.231.6/3011 c1 l1 ss2/65535 p1
Undo partial loss 209.167.177.93/1974 c1 l1 ss2/2 p1
parport0: Timed out
Undo partial loss 24.169.102.121/3177 c1 l1 ss2/65535 p1
Undo partial loss 216.234.231.6/3384 c1 l1 ss2/2 p1
Undo loss 207.33.153.2/61745 c2 l0 ss2/65535 p0
Undo partial loss 207.33.153.2/61745 c2 l1 ss2/65535 p1
Undo partial loss 207.33.153.2/61745 c1 l1 ss2/65535 p1
Undo loss 207.33.153.2/61745 c2 l0 ss2/65535 p0
Undo loss 207.33.153.2/61921 c2 l0 ss2/65535 p0
Undo loss 207.33.153.2/61921 c2 l0 ss2/65535 p0
Undo partial loss 216.234.231.6/2008 c1 l1 ss2/2 p1
Undo partial loss 24.169.102.121/3423 c1 l1 ss2/65535 p1
Undo partial loss 216.234.231.6/4252 c1 l1 ss2/2 p1
Undo partial loss 216.234.231.5/55504 c1 l1 ss2/65535 p1
Undo loss 207.33.153.2/61448 c2 l0 ss2/65535 p0
Undo partial loss 207.33.153.2/61448 c1 l1 ss2/65535 p1
Undo loss 207.33.153.2/61448 c2 l0 ss2/65535 p0
Undo loss 207.33.153.2/61448 c2 l0 ss2/65535 p0         


