Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129350AbRBMXPX>; Tue, 13 Feb 2001 18:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130284AbRBMXPQ>; Tue, 13 Feb 2001 18:15:16 -0500
Received: from c266492-a.lakwod1.co.home.com ([24.1.8.253]:42244 "EHLO
	benatar.snurgle.org") by vger.kernel.org with ESMTP
	id <S129350AbRBMXPG>; Tue, 13 Feb 2001 18:15:06 -0500
Date: Tue, 13 Feb 2001 18:14:49 -0500 (EST)
From: William T Wilson <fluffy@snurgle.org>
To: Jeremy Jackson <jeremy.jackson@sympatico.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is this the ultimate stack-smash fix?
In-Reply-To: <3A899FEB.D54ABBC7@sympatico.ca>
Message-ID: <Pine.LNX.4.21.0102131812260.14569-100000@benatar.snurgle.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Jeremy Jackson wrote:

> Next, gcc doesn't generate any code which would be placed in the
> stack, nor does it generate any calls/jumps to the stack area.

Unfortunately, you can't count on this.  Objective C, for one, requires an
executable stack.

While there have been "unofficial" patches (Solar Designer) to lock out
executing the stack for a long time, and it does work in most cases, this
isn't really doable as a general solution.


