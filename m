Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277256AbRJDWav>; Thu, 4 Oct 2001 18:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277257AbRJDWam>; Thu, 4 Oct 2001 18:30:42 -0400
Received: from [208.129.208.52] ([208.129.208.52]:19211 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S277256AbRJDWac>;
	Thu, 4 Oct 2001 18:30:32 -0400
Date: Thu, 4 Oct 2001 15:35:35 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Benjamin LaHaise <bcrl@redhat.com>
cc: "David S. Miller" <davem@redhat.com>, <rgooch@ras.ucalgary.ca>,
        <arjan@fenrus.demon.nl>, <kravetz@us.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Context switch times
In-Reply-To: <20011004175526.C18528@redhat.com>
Message-ID: <Pine.LNX.4.40.0110041530170.1022-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2001, Benjamin LaHaise wrote:

> On Thu, Oct 04, 2001 at 02:52:39PM -0700, David S. Miller wrote:
> > So the FPU hit is only before/after the runs, not during each and
> > every iteration.
>
> Right.  Plus, the original mail mentioned that it was hitting all 8
> CPUs, which is a pretty good example of braindead scheduler behaviour.

There was a discussion about process spinning among idle CPUs a couple of
months ago.
Mike, did you code the patch that stick the task to an idle between the
send-IPI and the idle wakeup ?
At that time we simply left the issue unaddressed.



- Davide


