Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270748AbTGUWsR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 18:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270753AbTGUWsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 18:48:17 -0400
Received: from law15-f43.law15.hotmail.com ([64.4.23.43]:46342 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S270748AbTGUWsQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 18:48:16 -0400
X-Originating-IP: [212.152.91.179]
X-Originating-Email: [ef057@hotmail.com]
From: "Bryan K." <ef057@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: MTRRs question
Date: Mon, 21 Jul 2003 23:03:18 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law15-F43PuZ91Bo1At0002a457@hotmail.com>
X-OriginalArrivalTime: 21 Jul 2003 23:03:18.0713 (UTC) FILETIME=[46498A90:01C34FDC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an athlon-tbird cpu with 768MB and I am doing some experiments with 
MTRRs. I want to have the first 512 MB of ram write-back and the rest 256 
uncachable. So i (would like to) do:

echo "base=0x00000000 size=0x20000000 type=write-back" > /proc/mtrr
echo "base=0x20000000 size=0x10000000 type=uncachable" > /proc/mtrr

But after the execution of the first command and before I complete the 
typing of the second the system hangs.
What is really a mystery for me is that if i do the echos in the opposite 
order, meaning

echo "base=0x20000000 size=0x10000000 type=uncachable" > /proc/mtrr
echo "base=0x00000000 size=0x20000000 type=write-back" > /proc/mtrr

everyting works as expected.
I would be grateful if someone cound give me some explanation of this.
Thank you in advance.

_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

