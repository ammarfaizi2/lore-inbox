Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbSKMAQS>; Tue, 12 Nov 2002 19:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbSKMAQS>; Tue, 12 Nov 2002 19:16:18 -0500
Received: from skyline.vistahp.com ([65.67.58.21]:43398 "HELO
	escalade.vistahp.com") by vger.kernel.org with SMTP
	id <S267048AbSKMAQR>; Tue, 12 Nov 2002 19:16:17 -0500
Message-ID: <20021113002529.7413.qmail@escalade.vistahp.com>
From: "Brian Jackson" <brian-kernel-list@mdrx.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: md on shared storage
Date: Tue, 12 Nov 2002 18:25:29 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a question for all those out there that are smarter than me(so I 
guess that's most of you then :) I looked around (google, kernel source, 
etc.) trying to find the answer, but came up with nothing. 

Does the MD driver work with shared storage? I would also be interested to 
know if the new DM driver works with shared storage(though I must admit I 
didn't really try to answer this one myself, just hoping somebody will 
know). 

I ask because I seem to be having some strange problems with an md device on 
shared storage(Qlogic FC controllers). The qlogic drivers spit out messages 
for about 20-60 lines then the machines lock up. So the drivers were my 
first suspicion, but they were working okay before. So I went back and got 
rid of the md device and now everything is working again. Anybody got any 
ideas? 

My logic says that it should work fine with shared storage, but my recent 
experience says my logic is wrong. 

 --Brian Jackson
