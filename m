Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268198AbTALCC4>; Sat, 11 Jan 2003 21:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268197AbTALCC4>; Sat, 11 Jan 2003 21:02:56 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:53130 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id <S268200AbTALCCz>;
	Sat, 11 Jan 2003 21:02:55 -0500
Date: Sun, 12 Jan 2003 02:11:37 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: Linux VM Documentation - Draft 1
Message-ID: <Pine.LNX.4.44.0301120210580.32623-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, despite numerous setbacks, disasters and various panic-attacks, I've
finally got a first draft together for documentation of the Linux VM. This
is still incomplete but will hopefully still be a valuable resource to
those wishing to understand the VM.

It is based on 2.4.20 as the 2.5.x one still changes too much too
regularly to make documenting it feasible. I do believe though that having
a good understanding of the 2.4.20 VM is 80% of the work to understanding
the 2.5.x one at least. There is a few notable areas not covered yet but
will be over the next month or two but I am releasing this early so I can
start getting feedback and correcting any errors or poor assumptions now
rather than later. The areas are;

o Swap area management   (swap.c, swapfile.c etc)
o High memory management (highmem.c)
o Memory locking         (mlock.c)
o Mem init (May not cover as it's very arch specific and there is docs out
            there on the subject already)
o Shared memory (May not cover this at all as it is really an IPC field)
o Buffer management (Same, except it's of more importance to IO)

The documentation comes in two parts. The first is "Understanding the
Linux Virtual Memory Manager" and it does pretty much as described. It is
available in three formats, PDF, HTML and plain text.

Understanding the Linux Virtual Memory Manager
PDF:  http://www.csn.ul.ie/~mel/projects/vm/guide/pdf/understand.pdf
HTML: http://www.csn.ul.ie/~mel/projects/vm/guide/html/understand/
Text: http://www.csn.ul.ie/~mel/projects/vm/guide/text/understand.txt

The second part is a code commentary which is literally a guided tour
through the code. It is intended to help decipher the more cryptic
sections as well as identify the code patterns that are prevalent through
the code. I decided to have the code separate from the first document as
maintaining the code in the document would be too painful

Code Commentary on the Linux Virtual Memory Manager
PDF:  http://www.csn.ul.ie/~mel/projects/vm/guide/pdf/code.pdf
HTML: http://www.csn.ul.ie/~mel/projects/vm/guide/html/code
Text: http://www.csn.ul.ie/~mel/projects/vm/guide/text/code.txt

Any feedback, comments or suggestions are welcome from anyone with a VM
interest but I would appreciate if people already familiar with the VM
would even give a brief read to check for technical accuracy. There was
rarely an authoritative source to check to make sure I was right and I
didn't want to be asking questions every 5 minutes on IRC or mailing
lists :-)

Enjoy...

-- 
Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel



