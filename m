Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290548AbSARATm>; Thu, 17 Jan 2002 19:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290549AbSARATX>; Thu, 17 Jan 2002 19:19:23 -0500
Received: from gw.wmich.edu ([141.218.1.100]:33764 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S290548AbSARATL>;
	Thu, 17 Jan 2002 19:19:11 -0500
Subject: 2.4.18-pre3-ac2 spiffyness
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 17 Jan 2002 19:19:02 -0500
Message-Id: <1011313147.13035.54.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, in all my graph creating and kernels tested, I've never seen
anything so clean as what I have seen in this kernel.  I haven't tested
it completely but all those arguments from the bsd and other kernel
people about vm instability is thrown to the wayside with this one.  
Check out this http://safemode.homeip.net/2.4.18-pre3-ac2_mem.png  I
must say I was surprised to see something so clean looking for a testing
sample where I was doing so much.   

Just to mention again what these graphs are based on:  I do my testing
with my actual load, no synthetic pretend loads that I never see or
doing things that I'll never do again, or running programs that try and
simulate what I do.  I dont see the point in benchmarking for loads,
there's always some combination you can't think of when you find a
benchmark. Everyone interested should just do their worst and describe
what they did to get the numbers they got.  More quantitative reports
and less of that qualitative "it feels" nice reports.   yup.  

What was done:
	prior to starting vmstat I was running cdparanoia -B "1-" on a non-dma
cdrom (less dma timeouts and atapi resets that way).  Decoding and
playing vorbis files while jumping between desktops loaded with
terminals and mozilla/Evolution.  Browsing websites and scrolling them
while traversing huge email directories in evolution.   All the while
xawtv is playing fullscreen using xv.  (not to mention various non-gui
apps that aren't really impacting the system). 

any Conclusions:
	So far I've seen nothing wrong with it. Anyone who wants the vmstat
output can email me for it.  It's far too soon to make any real
conclusions about the subsystems or anything yet though.  Haven't
checked to see the plain 2.4.18-pre3 kernel behavior but I will once I
get everything back in order and have some free time.  I just couldn't
wait to see what other people thought of this kind of smooth behavior.  

I'm not giving as much info as prior kernels due to my school being
network nazi's.  Funny, you goto college seeking knowledge but you're
disabled from sharing any of your own.  +1 to ipv4 and college.  



