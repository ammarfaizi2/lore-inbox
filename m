Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpGnVyHPBPIpuQlyXdGaibCBPoQ==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 04:27:54 +0000
Message-ID: <019d01c415a4$69d5b6d0$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
X-AuthUser: davidel@xmailserver.org
Date: Mon, 29 Mar 2004 16:42:16 +0100
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
From: "Davide Libenzi" <davidel@xmailserver.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: <Administrator@smtp.paston.co.uk>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
        <mingo@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-Reply-To: <20040104015037.AE9A62C0AB@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN;
	charset="US-ASCII"
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:42:18.0390 (UTC) FILETIME=[6ACDAB60:01C415A4]

On Sat, 3 Jan 2004, Rusty Russell wrote:

> Still do.  It's *simple*, and I refuse to be ashamed of that.
> 
> My words were harsh, but I completely disagree with you.  I believe
> you are wrong.  I would never have coded it the way you did.  I read
> your code and I still think you are wrong, and find your code both
> bloated and ugly.

Bloated ? This is the diffstat of my "ashamed" patch over your bits :-)

include/linux/init_task.h |    3 +
include/linux/sched.h     |    8 ++++
kernel/kthread.c          |   78 ++++++++++++++++------------------------------
3 files changed, 39 insertions(+), 50 deletions(-)



> Now, on something we do agree: I dislike the global structure myself.
> By all means try changing the code to use a pipe between child and
> parent for the initfn result.  But I've told you that I will not
> submit any solution which adds to a generic structure for a specific
> problem.
> 
> I'm very, very sorry this has gotten a little heated: I generally
> enjoy our discussions.  But I don't think I should have to say "no"
> four times.

It's ok Rusty, I enjoy the discussion in any case :-) Since I told you in 
a private email that I was convinced myself about adding stuff inside the 
struct, you could have avoided the "ashamed" thing. But it's fine, a 
little bit of sarcasm is the salt of life.




- Davide


