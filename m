Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319223AbSHMX5f>; Tue, 13 Aug 2002 19:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319224AbSHMX5f>; Tue, 13 Aug 2002 19:57:35 -0400
Received: from wotug.org ([194.106.52.201]:11570 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id <S319223AbSHMX5e>;
	Tue, 13 Aug 2002 19:57:34 -0400
Date: Wed, 14 Aug 2002 00:59:27 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: linux-kernel@vger.kernel.org
Subject: RFC: help with pdc202 changes
Message-ID: <Pine.LNX.4.44.0208140053330.25777-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

As indicated in other mailings, I have been looking at the pdc202xx driver.  
One 'issue' it has (in common with several other ide controller drivers) is
that while it exports a /proc entry that describes the configuration of the
controller, that entry only describes the first controller found. As I have 2
controllers in my machine (and it could be 3), that's not optimal.

I have been working on a patch to fix that. It is now in a state of
compiles-but-not-tested. Is there anyone who could have a look and see if it
ought to work? Once I have some confidence in it, I'll give it a go...

I am wary of testing it "blind" as I don't have a dedicated test machine, so
I'd prefer not to play fast and loose with my server :-)

Thanks,

Ruth

-- 
Ruth Ivimey-Cook
Software engineer and technical writer.

