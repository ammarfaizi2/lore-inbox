Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbUENSlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUENSlK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 14:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUENSlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 14:41:09 -0400
Received: from main.gmane.org ([80.91.224.249]:2191 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262052AbUENSk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 14:40:57 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Christian Riedel <sarek@nurfuerspam.de>
Subject: [V4L] video crashes perodically
Date: Fri, 14 May 2004 20:37:27 +0200
Message-ID: <c833l7$963$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p508a64f6.dip.t-dialin.net
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a problem with getting my tv-tuner card to work ... I loaded the 
modules with the right parameters for my card. When I start a tv 
application (be it zapping, xawtv or tvtime) I get video and sound just 
fine. However after a certain time (maybe 10 minutes) video starts 
crashing periodically: first luminance seems to vbe turned up step by 
step and after about 2 minutes video is hardly visible. Then sound 
collapses, video gets heavy distortions and a few seconds later video 
and sound switch back to normal. To illustrate the problem here ( 
http://sarek.webhop.org/tv ) are some screenshots - taken each 5 seconds 
approx.

I dont think that this a hardware problem, as the tv-tuner card works 
just fine - even for serveral hours nonstop tv - under windows.

I had this card working several months ago (using kernel 2.4.x or even 
earlier) but now using 2.6.x I can't get it working again

The card is a Typhoon TVCapturer (CPH031, Bt848a, Tuner Temic 4002FH5)
As module params I use card=59 tuner=0 for bttv and type=0 for tuner. 
These settings used to work fine before.

My system is debian/sid running kernel 2.6.5-3

I hope anyone of you can help me.

Thanks in advance

	Christian
-- 
To reply to this posting directly use the following address and
remove the 'NO-SPAM' part: Riedel.Christian.NO-SPAM@gmx.net

