Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbSLOWTD>; Sun, 15 Dec 2002 17:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262924AbSLOWTD>; Sun, 15 Dec 2002 17:19:03 -0500
Received: from conductor.synapse.net ([199.84.54.18]:24083 "HELO
	conductor.synapse.net") by vger.kernel.org with SMTP
	id <S262871AbSLOWTC> convert rfc822-to-8bit; Sun, 15 Dec 2002 17:19:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: "D.A.M. Revok" <marvin@synapse.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133 Promise ctrlr, or...
Date: Sun, 15 Dec 2002 17:25:57 -0500
User-Agent: KMail/1.4.1
References: <200212152139.gBFLdI1p002059@darkstar.example.net>
In-Reply-To: <200212152139.gBFLdI1p002059@darkstar.example.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212151725.57046.marvin@synapse.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man, the Magic SysReq key didn't work ( at all ):
it were DEAD
The drive-light stayed on for 10+ hours, nothing happening ( that I could 
figure out ) the whole time.  It /stayed/ dead.

/dev/hde is part of a RAID-5 in my system ( because I no longer trust 
anything else ), and this only happens on drives connected onto the 
Promise controller.

Oh, yeah, I forgot to include this:
trying to touch/activate/read the S.M.A.R.T. in any drive on the Promise 
kills it, too.  Can't activate the reliability-system without killing 
the kernel? /that's/ ironic, eh?


As for having another terminal connected to my home machine...
1. if the kernel's dead, then how's that gonna work, and
2. why have 2 terminals on one machine when I'm a hermit?

I /do/ thank you for the interface-reset tip, though, I hope I never need 
that info  : )

On Sun 15 December, 2002 16:39, you wrote:
>> have to use the power-switch to get the machine back
>
>If you have another terminal accessible, you could try:
>
>hdparm -w /dev/hda
>
>to reset the interface.  I can't guarantee that it wouldn't loose
>data, though.
>
>John.

-- 
http://www.drawright.com/
 - "The New Drawing on the Right Side of the Brain" ( Betty Edwards, 
check "Theory", "Gallery", and "Exercises" )
http://www.ldonline.org/ld_indepth/iep/seven_habits.html
 - "The 7 Habits of Highly Effective People" ( this site is same 
principles as Covey's book )
http://www.eiconsortium.org/research/ei_theory_performance.htm
 - "Working With Emotional Intelligence" ( Goleman: this link is 
/revised/ theory, "Working. . . " is practical )
http://www.leadershipnow.com/leadershop/1978-5.html
 - Corps Business: The 30 /Management Principles/ of the U.S. Marines ( 
David Freedman )
