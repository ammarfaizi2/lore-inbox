Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268970AbRHWP4c>; Thu, 23 Aug 2001 11:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269041AbRHWP4X>; Thu, 23 Aug 2001 11:56:23 -0400
Received: from [208.187.172.194] ([208.187.172.194]:54031 "HELO
	odin.oce.srci.oce.int") by vger.kernel.org with SMTP
	id <S268997AbRHWP4T>; Thu, 23 Aug 2001 11:56:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Joshua Schmidlkofer <menion@srci.iwpsd.org>
To: Bob Glamm <glamm@mail.ece.umn.edu>
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Date: Thu, 23 Aug 2001 09:55:46 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010822030807.N120@pervalidus> <20010823140555.A1077@newton.bauerschmidt.eu.org> <20010823103620.A6965@kittpeak.ece.umn.edu>
In-Reply-To: <20010823103620.A6965@kittpeak.ece.umn.edu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01082309554604.03507@widmers.oce.srci.oce.int>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe it's just me, but adding a dependency solely for the sake of
> building the kernel doesn't strike me as very clean or elegant.
>

IMHO that is a highly suspect view.  Kernel building is already a hideously 
complicated problem [At least it seems so to me].   I am certainly in favor 
using a more intelligent and capable scripting lang to add capability and 
reduce some of the dependancy & symbol issues. If all we are doing is adding 
a different front end, it's not of much point, but some genuises here have 
streched make + shell to about as far as one can.  So if that can be done 
with make, someone surley can replace all that with Python.  [However, maybe 
I have missed the scope of the inclusion of python]
  Also, I would like to point out that while Python does have a 'flavor of 
the month' look for some people, it is a useable stable solution.  Who 
knows what my supercede it tomorrow, but as a whole it's maturing, and I 
personally use it a TON.   Plus it has a powerful library.  

Side note:
    It took about 10 days for the last kernel compile I did on my 386sx 16 
[whopping 32 megs of ram thought =] [that was a while ago]..   I suspect that 
with python it wouldn't actually take much longer.   Besides, I compile 
kernels for it on something else.
