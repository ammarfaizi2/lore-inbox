Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264212AbRFFWjN>; Wed, 6 Jun 2001 18:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264216AbRFFWjD>; Wed, 6 Jun 2001 18:39:03 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:56328 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S264215AbRFFWiy>; Wed, 6 Jun 2001 18:38:54 -0400
Subject: Re: Break 2.4 VM in five easy steps
From: Robert Love <rml@tech9.net>
To: android <linux@ansa.hostings.com>
Cc: Jonathan Morton <chromi@cyberspace.org>, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20010606152347.028e21d0@ansa.hostings.com>
In-Reply-To: <5.1.0.14.2.20010606143453.028ed400@ansa.hostings.com>
	<9fm4t7$412$1@penguin.transmeta.com> <3B1D5ADE.7FA50CD0@illusionary.com> 
	<5.1.0.14.2.20010606152347.028e21d0@ansa.hostings.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10 (Preview Release)
Date: 06 Jun 2001 18:38:44 -0400
Message-Id: <991867131.807.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 Jun 2001 15:27:57 -0700, android wrote:
> >I sincerely hope you're joking.
>
> I realize that assembly is platform-specific. Being that I use the IA32 class
> machine, that's what I would write for. Others who use other platforms could
> do the deed for their native language.<snip>

no, look at the code. it is not going to benefit from assembly (assuming
you can even implement it cleanly in assembly).  its basically an
iteration of other function calls.

doing a new implementation in assembly for each platform is not
feasible, anyhow. this is the sort of thing that needs to be uniform.

this really has nothing to do with the "iron" of the computer -- its a
loop to check and free swap pages. assembly will not provide benefit.

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

